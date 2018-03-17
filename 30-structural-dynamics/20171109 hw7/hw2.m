% 消除前一次作業
clc; clear; close all;

t = 0 : 0.0001 : 10 * pi;

R = 1 - cos(t);

plot(t, R);

grid on;

xlabel('w_n * t');
ylabel('R(t)');
