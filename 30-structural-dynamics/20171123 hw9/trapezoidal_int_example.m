clc
%------------------
% Example: Slide 5-7
%------------------

%------------------
% Create a "cos" function = 2*pi*0.1*sin(2*pi*0.1*t)
% and its integral is cos(2*pi*0.1*t)
%------------------
tt = (0:1/200:30)';
p_t = 2*pi*0.1*cos(2*pi*0.1*tt);
p_t_int = sin(2*pi*0.1*tt);

%------------------
% Use definition to calculate the integral
%------------------
p_t_int_cal = zeros(size(p_t_int));
%==
dt = tt(2)-tt(1);
for i = 2:length(tt)
    p_t_int_cal(i) = dt*0.5*(p_t(i-1) + p_t(i)) + p_t_int_cal(i-1);
end

%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 900 600]);
plot(tt,p_t_int,'b-','linewidth',2.5);hold on
plot(tt,p_t_int_cal,'r--','linewidth',0.8);hold off
legend('exact','numerical');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('integral','fontsize',14);

%------------------
% Create a "sin" function = 2*pi*0.1*sin(2*pi*0.1*t)
% and its integral is -cos(2*pi*0.1*t)
%------------------
tt = (0:1/200:30)';
p_t = 2*pi*0.1*sin(2*pi*0.1*tt);
p_t_int = -cos(2*pi*0.1*tt);

%------------------
% Use definition to calculate the integral
%------------------
p_t_int_cal = zeros(size(p_t_int));
%==
dt = tt(2)-tt(1);
for i = 2:length(tt)
    p_t_int_cal(i) = dt*0.5*(p_t(i-1) + p_t(i)) + p_t_int_cal(i-1);
end

%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 900 600]);
plot(tt,p_t_int,'b-','linewidth',2.5);hold on
plot(tt,p_t_int_cal,'r--','linewidth',0.8);hold off
legend('exact','numerical');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('integral','fontsize',14);

%------------------
% Create a "cos" function = 2*pi*0.1*sin(2*pi*0.1*t)
% and its integral is cos(2*pi*0.1*t)
%------------------
tt = (0:1/10:30)';
p_t = 2*pi*0.1*cos(2*pi*0.1*tt);
p_t_int = sin(2*pi*0.1*tt);

%------------------
% Use definition to calculate the integral
%------------------
p_t_int_cal = zeros(size(p_t_int));
%==
dt = tt(2)-tt(1);
for i = 2:length(tt)
    p_t_int_cal(i) = dt*0.5*(p_t(i-1) + p_t(i)) + p_t_int_cal(i-1);
end

%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 900 600]);
plot(tt,p_t_int,'b-','linewidth',2.5);hold on
plot(tt,p_t_int_cal,'r*--','linewidth',0.8);hold off
legend('exact','numerical');legend('boxoff');
xlabel('time (sec)','fontsize',14);
ylabel('integral','fontsize',14);