clc; clear; close all;

%------------------
% Load input ground motion
%------------------
load ELC_input % "tt_acc" will show up in Workspace.
% The first column in tt_acc is the time vector
% The second column in tt_acc is the ground acceleration in m/sec^2
dt = tt_acc(2,1)-tt_acc(1,1);
%------------------
% Parameters
%------------------
dmp = [0 2 5 10 20] / 100;

%------------------
% Figure Setting
%------------------
figure;
lineColor = ['r', 'g', 'b', 'c', 'k'];

%------------------
% Crate a big for-loop
%------------------
for index = 1 : 5
Tn = (0.1:0.1:5)';
wn = 2*pi*(1./Tn);
max_disp = zeros(size(Tn));
max_acc = zeros(size(Tn));
%==
for i = 1:length(wn)
    Ac = [0 1;-wn(i)^2 -2*dmp(index)*wn(i)];
    Bc = [0; -1];
    Cc = [1 0;[-wn(i)^2 -2*dmp(index)*wn(i)]]; % displacement and abs. acceleration
    Dc = [0;0];
    %==
    sim('eq_analysis',[0 100]);
    %==
    max_disp(i) = max(abs(y(:,1)));
    max_acc(i) = max(abs(y(:,2)));
end

%------------------
% Plot
%------------------
subplot(2,1,1);
plot(Tn,max_disp,lineColor(index),'linewidth',2.5);
hold on;

subplot(2,1,2);
plot(Tn,max_acc,lineColor(index),'linewidth',2.5);
hold on;

end

%------------------
% Figure Setting
%------------------
set(gcf,'position',[50 50 800 600]);
subplot(2,1,1);
xlabel('period (sec)','fontsize',14);
ylabel('displacement (m)','fontsize',14);
legend('0%', '2%', '5%', '10%', '20%');


subplot(2,1,2);
xlabel('period (sec)','fontsize',14);
ylabel('acceleration (g)','fontsize',14);
legend('0%', '2%', '5%', '10%', '20%');
