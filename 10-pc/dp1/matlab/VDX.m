clc; clear; close all;

period = 1.386;

% RF - 2F
modeShape = [0.063983 0.057168 0.047196 0.034396 0.020212 0.00755].';

m = [92.92164 86.72686 86.72686 86.72686 86.72686 86.72686].';

numDamper = 4;

xid = 0.16 - 0.02;

cosTheta = [
    0.9 / sqrt(0.4 ^ 2 + 0.9 ^ 2);
    0.9 / sqrt(0.4 ^ 2 + 0.9 ^ 2);
    0.9 / sqrt(0.4 ^ 2 + 0.9 ^ 2);
    0.9 / sqrt(0.4 ^ 2 + 0.9 ^ 2);
    0.9 / sqrt(0.4 ^ 2 + 0.9 ^ 2);
    0.9 / sqrt(0.45 ^ 2 + 0.9 ^ 2);
];

storyDrift = 0.012;

h = 24.5;

alpha_ = 0.6;

% =======================================

omega = 2 * pi / period;

NormalizeModeShape = modeShape(:, 1) / modeShape(1, 1);

nextReducePrev = diag(ones(1, length(modeShape)), 0) - diag(ones(1, length(modeShape) - 1), 1);

relativeModeShape = nextReducePrev * NormalizeModeShape;

A = storyDrift * h / max(relativeModeShape);

lambda = (2 ^ (2 + alpha_)) * (gamma(1 + alpha_ / 2) ^ 2) / gamma(2 + alpha_);

c_nonlinear = 2 * pi * xid * (A ^ (1 - alpha_)) * (omega ^ (2 - alpha_)) * sum((m .* (NormalizeModeShape .^ 2))) / (lambda * sum((relativeModeShape .^ (1 + alpha_)) .* (cosTheta .^ (1 + alpha_)))) / numDamper

c_linear = 4 * pi * xid * sum(m .* NormalizeModeShape .^ 2) / (period * sum((cosTheta .^ 2) .* (relativeModeShape .^ 2))) / numDamper
