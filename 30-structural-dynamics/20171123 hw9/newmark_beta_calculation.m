function [u,v,a] = newmark_beta_calculation(m,c,k,up,vp,ap,dp,dt,gamma,beta)

%------------------
% Calculate effective stiffness
%------------------
k_s = k + gamma/beta/dt*c + 1/beta/dt^2*m;

%------------------
% Compute coefficients a and b
%------------------
a = 1/beta/dt*m + gamma/beta*c;
b = 1/2/beta*m + dt*(gamma/2/beta-1)*c;

%------------------
% Calculate effective excitation and all responses
%------------------
dp_s = dp + a*vp + b*ap;
%~~
du = dp_s/k_s;
%==
dv = gamma/beta/dt*du - gamma/beta*vp - dt*(1-gamma/2/beta)*ap;
da = 1/beta/dt^2*du - 1/beta/dt*vp - 1/2/beta*ap;
%~~
u = up + du;
v = vp + dv;
a = ap + da;