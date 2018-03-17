clc
%------------------
% Slide 15
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
%~~
up = u(1) - dt*v(1) + dt^2/2*a(1);
uc = u(1);
for i = 1:(length(tt)-1)
    [u(i+1),v(i),a(i)] = central_diff_calculation(m,c,k,uc,up,p_t(i),dt);
    %==
    up = u(i);
    uc = u(i+1);
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
