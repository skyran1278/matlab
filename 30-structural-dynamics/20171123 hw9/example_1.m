clc
%------------------
% Slide 15
%------------------

%------------------
% Parameters (k wn h) and time vector
%------------------
k = 40;
wn = 20;
h = 0.02;
%==
tt = (0:h:10)';

%------------------
% Define the input excitation
%------------------
p_t = 10*cos(10*tt);

%------------------
% Calculate coefficients
%------------------
A = 1/k/wn/h*(sin(wn*h)-wn*h*cos(wn*h));
B = 1/k/wn/h*(wn*h-sin(wn*h));
C = cos(wn*h);
D = 1/wn*sin(wn*h);
%==
A1 = 1/k/h*(wn*h*sin(wn*h)+cos(wn*h)-1);
B1 = 1/k/h*(1-cos(wn*h));
C1 = -wn*sin(wn*h);
D1 = cos(wn*h);

%------------------
% Calculate response (starts from rest)
%------------------
u = zeros(size(p_t));
v = zeros(size(p_t));
%==
for i = 2:length(tt)
    u(i) = A*p_t(i-1)+ B*p_t(i) + C*u(i-1) + D*v(i-1);
    v(i) = A1*p_t(i-1) + B1*p_t(i) + C1*u(i-1) + D1*v(i-1);
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