clc; clear; close all;

m = [1.21129 1.20846 0.96506].';

period = 0.3290;
omega = 2 * pi / period;

modeshape = [0.2683 0.5520 0.7489].';

modeshape_normailzed = modeshape(:, 1) / modeshape(3, 1);

xi_d = 0.18;

cos_theta = [(2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.5 ^ 2), (2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.25 ^ 2), (2.25 / 3) / sqrt((2.25 / 3) ^ 2 + 1.25 ^ 2)].';

next_reduce_prev = [
    1, 0, 0;
    -1, 1, 0;
    0, -1, 1;
];

relative_modeshape = next_reduce_prev * modeshape_normailzed;

c_linear = 4 * pi * xi_d * sum(m .* modeshape_normailzed .^ 2) / (period * sum((cos_theta .^ 2) .* (relative_modeshape .^ 2)))
% 149


story_drift = 0.01;

h = 1.5;

u0 = story_drift * h * cos_theta;

% linear
% FD_linear = c_linear * u0 * omega

% =========================
% nonlinear
alpha_ = 0.3;

A = story_drift * h / max(relative_modeshape);

lamda = 2 ^ (2 + alpha_) * gamma(1 + alpha_ / 2) ^ 2 / gamma(2 + alpha_);

c_nonlinear = 2 * pi * xi_d * A ^ (1 - alpha_) * omega ^ (2 - alpha_) * sum((m .* modeshape_normailzed .^ 2)) / (lamda * sum(relative_modeshape .^ (1 + alpha_) .* cos_theta .^ (1 + alpha_)))
% 49


% FD_nonlinear = c_nonlinear * (omega * u0) ^ alpha_

% =========================
% nonlinear
alpha_ = 0.7;

A = story_drift * h / max(relative_modeshape);

lamda = 2 ^ (2 + alpha_) * gamma(1 + alpha_ / 2) ^ 2 / gamma(2 + alpha_);

c_nonlinear = 2 * pi * xi_d * A ^ (1 - alpha_) * omega ^ (2 - alpha_) * sum((m .* modeshape_normailzed .^ 2)) / (lamda * sum(relative_modeshape .^ (1 + alpha_) .* cos_theta .^ (1 + alpha_)))
% 93


% FD_nonlinear = c_nonlinear * (omega * u0) ^ alpha_
