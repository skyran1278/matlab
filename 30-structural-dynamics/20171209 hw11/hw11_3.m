clc; clear; close all;

t = 0 : 0.01 : 1;

seta1 = sin(pi * t / 1);
seta2 = sin(2 * pi * t / 1);

subplot(2,1,1);
plot(t, seta1);
xlabel('L');
ylabel('\Phi');
% set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'first mode shape');

subplot(2,1,2);
plot(t, seta2);
xlabel('L');
ylabel('\Phi');
% set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'second mode shape');
