clc; clear; close all;

Vp = 148.78; % t

Mp = 162.62; % t-m

rx = 20.9; % cm

ry = 7.2; % cm

lx = 3.5; % m

ly = 1.75; % m

Ag = 249; % cm^2


k = 1;

e = 1.3; % m

Ry = 1.2;

Fy = 3.3; % t / cm^2

E = 2039.432; % t / cm^2

% =================================

Vn = min(Vp, 2 * Mp / e)

Vu = 1.1 * Ry * Vn

Mu = Vu * e / 2

Pu = 1.1 * Vu / tan(angle_to_radian(45))

kl_over_r = max(k * lx * 100 / rx, k * ly * 100 / ry);

lambda = kl_over_r * sqrt(Fy / (pi ^ 2 * E))

Pn_c = (0.658 ^ (lambda ^ 2)) * Fy * Ag

Pn_t = Fy * Ag

Lp = 80 / sqrt(Fy) * ry

Mn = Mp

Pu / (0.9 * Ry * Pn_t)

DCR_t = Pu / (0.9 * Ry * Pn_t) + 8 / 9 * Mu / (0.9 * Ry  * Mn)

Pu / (0.85 * Ry * Pn_c)

DCR_c = Pu / (0.85 * Ry * Pn_c) + 8 / 9 * Mu / (0.9 * Ry  * Mn)
