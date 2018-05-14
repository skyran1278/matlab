clc; clear; close all;

rx = 15.0; % cm

ry = 9.3; % cm

Ag = 267; % cm^2

Vn = 148.78;

Vp = 0; % t

Mp = 0; % t-m

lx = 3.5; % m

ly = 3.5; % m

Pu = 32.64; % t

k = 1;

Ry = 1.2;

Fy = 3.3; % t / cm^2

E = 2039.432; % t / cm^2

% =================================

kl_over_r = max(k * lx * 100 / rx, k * ly * 100 / ry);

lambda = kl_over_r * sqrt(Fy / (pi ^ 2 * E))

Pn_c = (0.658 ^ (lambda ^ 2)) * Fy * Ag

Pn_t = Fy * Ag

DCR_t = Pu / (0.9 * Pn_t)

DCR_c = Pu / (0.85 * Pn_c)
