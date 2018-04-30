clc; clear; close all;
1.1*196.3896/sin(angle_to_radian(45))
rx = 13.7; % cm

ry = rx; % cm

Ag = 158.5; % cm^2

Vn = 148.78;

lx = 3.5 * sqrt(2); % m

ly = 3.5 * sqrt(2); % m


k = 1;

Ry = 1.2;

Fy = 3.5; % t / cm^2

E = 2039.432; % t / cm^2

% =================================

lambda_r = 63 / sqrt(Fy)

Vu = 1.25 * Ry * Vn

Pu = 1.1 * Vu / sin(angle_to_radian(45))

kl_over_r = max(k * lx * 100 / rx, k * ly * 100 / ry);

lambda = kl_over_r * sqrt(Fy / (pi ^ 2 * E))

Pn_c = (0.658 ^ (lambda ^ 2)) * Fy * Ag

Pn_t = Fy * Ag

DCR_t = Pu / (0.9 * Pn_t)

DCR_c = Pu / (0.85 * Pn_c)
