function [u, v, a] = newmark_beta_calculation(m, c, k, up, vp, ap, dp, dt, gamma_, beta_)

%------------------
% Calculate effective stiffness
%------------------
k_s = k + gamma_ / (beta_ * dt) * c + 1 / (beta_ * (dt ^ 2)) * m;

%------------------
% Compute coefficients a and b
%------------------
a = 1 / (beta_ * dt) * m + gamma_ / beta_ * c;
b = 1 / (2 * beta_) * m + dt * (gamma_ / (2 * beta_) - 1) * c;

%------------------
% Calculate effective excitation and all responses
%------------------
dp_s = dp + a * vp + b * ap;

%~~
du = dp_s / k_s;

%==
dv = gamma_ / (beta_ * dt) * du - gamma_ / beta_ * vp - dt * (1 - gamma_ / (2 * beta_)) * ap;
da = 1 / (beta_ * (dt ^ 2)) * du - 1 / (beta_ * dt) * vp - 1 / (2 * beta_) * ap;

%~~
u = up + du;
v = vp + dv;
a = ap + da;
