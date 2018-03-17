clc
%------------------
% Slide 45
%------------------

%------------------
% Parameters (k wn h) and time vector
%------------------
k = 40;
wn = 20;
c = 0;
dt = 0.01;
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
x = zeros(length(tt)+1,2);
y = zeros(length(tt),3);
%==
for i = 2:(length(tt)+1)
    [xtemp,ytemp] = dist_ss_approach(m,c,k,p_t(i-1),dt,x(i-1,:)');
    x(i,:) = xtemp';
    y(i-1,:) = ytemp';
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
plot(tt,y(:,1),'r-','linewidth',2.5);hold on
plot(tt,u_exact,'c--','linewidth',2.5);hold off
legend('calculated','exact');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('displacement (in)','fontsize',14);