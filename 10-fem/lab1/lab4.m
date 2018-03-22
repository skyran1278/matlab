clc; clear; close all;

L1 = 1;
L2 = 0.5;

A = 0 : 0.01 : 180;

Aradius = AngleToRadian(A);

d = L2 * cos(Aradius) + sqrt(L1 ^ 2 - (L2 * sin(Aradius)) .^ 2);

plot(A, d);

xlabel('A (degrees)');
ylabel('d (feet)');
grid on;
