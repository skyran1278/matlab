function [u,v,a] = central_diff_calculation(m,c,k,uc,up,pc,dt)

%------------------
% Calculate effective stiffness
%------------------
k_s = m/dt^2 + c/2/dt;

%------------------
% Calculate two parameters a and b
%------------------
a = m/dt^2 - c/2/dt;
b = k - 2*m/dt^2;

%------------------
% Calculate effective excitation and responses
%------------------
p_s = pc - a*up - b*uc;
%==
u = p_s/k_s;
v = (u-up)/2/dt;
a = (u-2*uc+up)/dt^2;