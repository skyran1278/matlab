clc; clear; close all;
%------------------
% Parameters
%------------------
wn = (2*pi)*1; % natural frequency = 1 Hz or Tn = 1 sec
dmp = 0.02; % damping ratio = 2 %
m = 100;
%==
k_lin = wn^2*m;
c = 2*dmp*wn*m;
%------------------
% Load input ground motion
%------------------
load ELC_input % "tt_acc" will show up in Workspace.
% The first column in tt_acc is the time vector
% The second column in tt_acc is the ground acceleration in m/sec^2
%==
acc_new = resample(tt_acc(:,2),1000,50);
tt_new = (0:(length(acc_new)-1))*1/1000';
dt = 1/1000;
%==

p_t = -m*acc_new;
%------------------
% Calculate response
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
a = zeros(size(p_t));
%~~
a(1) = 0;%1/m*(p_t(1)-c*v(1)-k*u(1));
gamma = 1/2;
beta = 1/4; % average acceleration method
for i = 2:length(tt_new)
dp = p_t(i) - p_t(i-1);
k = k_lin*(1+u(i-1)^2);
[u(i),v(i),a(i)] = newmark_beta_calculation(m,c,k,u(i-1),v(i-1),a(i-1),dp,dt,gamma,beta);
end
%------------------
% Calculate response using state-space approach
%------------------
x = zeros(length(tt_new)+1,2);
y = zeros(length(tt_new),3);
%==
for i = 2:(length(tt_new)+1)
k = k_lin*(1+x(i-1,1)^2);
[xtemp,ytemp] = dist_ss_approach(m,c,k,p_t(i-1),dt,x(i-1,:)');
x(i,:) = xtemp';
y(i-1,:) = ytemp';
end
%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 1200 800]);
plot(tt_new,[u,[0;y(1:end-1,1)]]);

legend('Newmark','State-Space');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('rel. displacement (m)','fontsize',14);
