% 消除前一次作業
clc; clear; close all;

t = 0 : 0.01 : 2;

u = 0.00654 - 0.00654 * cos(22.36 * t) + 0.021 * sin(22.36 * t);

plot(t, u, t, 0.00654 * ones(size(t, 2)));

grid on;

xlabel('Time (sec)');
ylabel('Displacement');