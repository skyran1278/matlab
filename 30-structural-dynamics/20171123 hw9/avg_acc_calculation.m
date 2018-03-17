function [u,v,a] = avg_acc_calculation(m,c,k,dp,up,vp,ap,dt)

%------------------
% Calculate k*
%------------------
k_s = k + 2 * c / dt + 4 * m / dt ^ 2;

%------------------
% Form dp*
%------------------
dp_s = dp + (4 * m / dt + 2 * c) * vp + 2 * m * ap;

%------------------
% Solve for du
%------------------
du = k_s \ dp_s;

%------------------
% Calculate dv and da
%------------------
dv = 2 / dt * du - 2 * vp;
da = 4 / dt ^ 2 * (du - vp * dt) - 2 * ap;

%------------------
% Output
%------------------
u = up + du;
v = vp + dv;
a = ap + da;
