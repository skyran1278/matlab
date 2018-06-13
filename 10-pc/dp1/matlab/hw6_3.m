clc; clear; close all;

m = [92.92164 86.72686 86.72686 86.72686 86.72686 86.72686].';

period = 1.386;
omega = 2 * pi / period;

% FIXME:
modeshape = [0.2683 0.5520 0.7489].';

% FIXME:
modeshape_normailzed = modeshape(:, 1) / modeshape(3, 1);

xi_d = 0.16;

% FIXME:
cos_theta = [(2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.5 ^ 2), (2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.25 ^ 2), (2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.25 ^ 2)].';

% FIXME:
next_reduce_prev = [
    1, 0, 0;
    -1, 1, 0;
    0, -1, 1;
];

relative_modeshape = next_reduce_prev * modeshape_normailzed;


story_drift = 0.012;

% FIXME:
h = 1.5;

u0 = story_drift * h * cos_theta;

alpha_ = 0.6;

A = story_drift * h / max(relative_modeshape);

lamda = 2 ^ (2 + alpha_) * gamma(1 + alpha_ / 2) ^ 2 / gamma(2 + alpha_);

c_nonlinear = 2 * pi * xi_d * A ^ (1 - alpha_) * omega ^ (2 - alpha_) * sum((m .* modeshape_normailzed .^ 2)) / (lamda * sum(relative_modeshape .^ (1 + alpha_) .* cos_theta .^ (1 + alpha_)))


