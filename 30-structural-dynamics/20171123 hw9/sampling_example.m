clc
%------------------
% Example: Slide 3
%------------------

%------------------
% Create a near continuous function
%------------------
tt = (0:1/2000:30)';
p_t = sin(2*pi*0.1*tt);

%------------------
% Typical sampling
%------------------
tt_pick = tt(1:500:end);
p_pick = p_t(1:500:end);

%------------------
% Plot
%------------------
figure();
set(gcf,'position',[50 50 900 600]);
plot(tt,p_t,'b-','linewidth',2.5);hold on
plot(tt_pick,p_pick,'ro','markersize',6,'markerfacecolor','r');hold off
xlabel('time (sec)','fontsize',14);
ylabel('excitation','fontsize',14);