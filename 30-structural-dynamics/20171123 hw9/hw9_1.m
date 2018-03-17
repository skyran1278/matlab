clc; clear; close all;

%------------------
% Parameters
%------------------
m = 100; % kg
wn = (2 * pi) * 1; % natural frequency = 1 Hz or Tn = 1 sec
dmp = 0.05; % damping ratio = 5 %

k = wn ^ 2 * m;
c = 2 * dmp * wn * m;

%------------------
% Load input ground motion
%------------------
load ELC_input % "tt_acc" will show up in Workspace.
% The first column in tt_acc is the time vector
% The second column in tt_acc is the ground acceleration in m/sec^2
tt = tt_acc(:,1);
acc = tt_acc(:,2);
dt = tt_acc(2,1)-tt_acc(1,1);

%------------------
% Define the input excitation
%------------------
p_t = -m * acc;

%------------------
% Calculate response
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
a = zeros(size(p_t));

%==
a(1) = 1 / m * (p_t(1) - c * v(1) - k * u(1));
%==

for index = 2 : length(tt)
dp = p_t(index) - p_t(index - 1);
up = u(index - 1);
vp = v(index - 1);
ap = a(index - 1);
[u(index), v(index), a(index)] = avg_acc_calculation(m,c,k,dp,up,vp,ap,dt);
end

%==
a_abs_Pa = a + acc; % problem (a)


%------------------
% Calculate response
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
a = zeros(size(p_t));
%==
a(1) = 1 / m * (p_t(1) - c * v(1) - k * u(1));
%==
up = u(1) - dt * v(1) + dt ^ 2 / 2 * a(1);
uc = u(1);
for index = 1 : (length(tt) - 1)
[u(index + 1), v(index), a(index)] = central_diff_calculation(m,c,k,uc,up,p_t(index),dt);
%==
up = u(index);
uc = u(index + 1);
end
%==
a_abs_Pb = a + acc; % problem (b)

%------------------
% Calculate response
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
a = zeros(size(p_t));
%~~
a(1) = 1/m*(p_t(1)-c*v(1)-k*u(1));
gamma = 1/2;
beta = 1/4;
for i = 2:length(tt)
dp = p_t(i) - p_t(i-1);
[u(i),v(i),a(i)] = newmark_beta_calculation(m,c,k,u(i-1),v(i-1),a(i-1),dp,dt,gamma,beta);
end
%==
a_abs_Pc = a + acc; % problem (c)

%------------------
% Calculate response
%------------------
x = zeros(length(tt)+1,2);
y = zeros(length(tt),3);
%==
for i = 2:(length(tt)+1)
[xtemp,ytemp] = dist_ss_approach(m,c,k,p_t(i-1),dt,x(i-1,:)');
x(i,:) = xtemp';
y(i-1,:) = ytemp';
end
%==
a_abs_Pd = y(:,end)+acc;
a_abs_Pd = [0;a_abs_Pd(1:end-1)];% problem (d)

%------------------
% Plot
%------------------

figure();
set(gcf,'position',[50 50 600 300]);
plot(tt,a_abs_Pa);
xlabel('time (sec)','fontsize',14);
ylabel('abs. acceleration (m/sec^2)','fontsize',14);
%==
figure();
set(gcf,'position',[50 50 600 300]);
plot(tt,a_abs_Pb);
xlabel('time (sec)','fontsize',14);
ylabel('abs. acceleration (m/sec^2)','fontsize',14);
%==
figure();
set(gcf,'position',[50 50 600 300]);
plot(tt,a_abs_Pc);
xlabel('time (sec)','fontsize',14);
ylabel('abs. acceleration (m/sec^2)','fontsize',14);
%==
figure();
set(gcf,'position',[50 50 600 300]);
plot(tt,a_abs_Pd);
xlabel('time (sec)','fontsize',14);
ylabel('abs. acceleration (m/sec^2)','fontsize',14);
%==
figure();
set(gcf,'position',[50 50 1200 800]);
subplot(2,2,1);
plot(tt,[a_abs_Pa,a_abs_Pb,a_abs_Pc,a_abs_Pd]);
legend('(a)','(b)','(c)','(d)');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('abs. acceleration (m/sec^2)','fontsize',14);
subplot(2,2,2);
plot(tt,a_abs_Pa-a_abs_Pd);
xlabel('time (sec)','fontsize',14);
ylabel('acceleration error (m/sec^2)','fontsize',14);

title('(a)-(d)','fontsize',14);
subplot(2,2,3);
plot(tt,a_abs_Pb-a_abs_Pd);
xlabel('time (sec)','fontsize',14);
ylabel('acceleration error (m/sec^2)','fontsize',14);
title('(b)-(d)','fontsize',14);
subplot(2,2,4);
plot(tt,a_abs_Pc-a_abs_Pd);
xlabel('time (sec)','fontsize',14);
ylabel('acceleration error (m/sec^2)','fontsize',14);
title('(c)-(d)','fontsize',14);
