% 消除前一次作業
clc; clear; close all;

t = 0 : 0.01 : 0.5;


u = exp(-7.246 * t) .* (0.1 * cos(72.10 * t) + 0.01005 * sin(72.10 * t));

plot(t, u);

xlabel('Time (sec)');
ylabel('Response');