% 消除前一次作業
clc; clear; close all;

t = 0 : 0.01 : 10;


u = 0.05 * exp(t) .* sin(2 * t);

plot(t, u);

xlabel('Time (sec)');
ylabel('Displacement');