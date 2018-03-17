clc
%------------------
% Slide 37
%------------------

%------------------
% Parameters (k wn h) and time vector
%------------------
k = 40;
wn = 20;
c = 0;
dt = 0.001;
%==
m = k/wn^2;
tt = (0:dt:10)';

%------------------
% Define the input excitation
%------------------
p_t = 10*cos(10*tt);

%------------------
% Calculate response
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
a = zeros(size(p_t));
%~~
a(1) = 1/m*(p_t(1)-c*v(1)-k*u(1));
gamma = 1/2;
beta = 1/4; % average acceleration method
for i = 2:length(tt)  
    dp = p_t(i) - p_t(i-1);
    [u(i),v(i),a(i)] = newmark_beta_calculation(m,c,k,u(i-1),v(i-1),a(i-1),dp,dt,gamma,beta);
end

%------------------
% Exact Solution
%------------------
u_exact = 1/3*(cos(10*tt) - cos(20*tt));

%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 900 600]);
plot(tt,u,'r-','linewidth',2.5);hold on
plot(tt,u_exact,'c--','linewidth',2.5);hold off
legend('calculated','exact');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('displacement (in)','fontsize',14);