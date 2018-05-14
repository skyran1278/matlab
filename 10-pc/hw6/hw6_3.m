clc; clear; close all;

m = 12e3;

k1 = 7e6;
k2 = 6.6e6;
k3 = 7e6;

ks = [
    k1 + k2, -k2, 0;
    -k2, k2 + k3, -k3;
    0, -k3, k3;
];

% TODO: mode shape �Ѧ첾�o�ӡA���O����
[modeshape, eig_k] = eig(ks);

omega = sqrt(eig_k(1, 1) / m);
period = 0.3290;

modeshape_normailzed = modeshape(:, 1) / modeshape(3, 1);

xi_d = 0.15;

cos_theta = 4 / 5;

next_reduce_prev = [
    1, 0, 0;
    -1, 1, 0;
    0, -1, 1;
];

relative_modeshape = next_reduce_prev * modeshape_normailzed;

% TODO: ���H 1000 ���N�q���ӲM��
c_linear = 4 * pi * xi_d * m * sum(modeshape_normailzed .^ 2) / (period * (cos_theta ^ 2) * sum(relative_modeshape .^ 2)) / 1000

story_drift = 0.01;

h = 3;

u0 = story_drift * h * cos_theta;

% linear
FD_linear = c_linear * u0 * omega

% =========================
% nonlinear
alpha_ = 0.7;

A = story_drift * h / max(relative_modeshape);

lamda = 2 ^ (2 + alpha_) * gamma(1 + alpha_ / 2) ^ 2 / gamma(2 + alpha_);

c_nonlinear = 2 * pi * xi_d * A ^ (1 - alpha_) * omega ^ (2 - alpha_) * sum(m * (modeshape_normailzed .^ 2)) / (lamda * sum(relative_modeshape .^ (1 + alpha_) * cos_theta ^ (1 + alpha_))) / 1000

FD_nonlinear = c_nonlinear * (omega * u0) ^ alpha_
