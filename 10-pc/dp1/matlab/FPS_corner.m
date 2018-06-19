clc; clear; close all;

hysteresis = xlsread('FPS_corner.xlsx', 1, 'C:D');
% edgeHysteresis = xlsread('FPS_corner edge center.xlsx', 1, 'G:H');
% centerHysteresis = xlsread('FPS_corner edge center.xlsx', 1, 'K:L');

W = 87.5997;
K1 = 1019.7;

R = 4.3812;
mu = 0.05;
DD = 0.2458;
x = -0.2458 : 0.0001 : 0.2458;
kh1 = W / R * x + mu * W;
kh2 = W / R * x - mu * W;
keD = (W / R + mu * W / DD) * x;
k11x = 0.237 : 0.0001 : 0.2458;
k11 = K1 * (k11x - 0.2458) + (W / R * 0.2458 + mu * W);
k12x = -0.237 : -0.0001 : -0.2458;
k12 = K1 * (k12x + 0.2458) + (W / R * (-0.2458) - mu * W);

figure;
designHysteresis = plot(x, kh1, 'k-', x, kh2, 'k-', x, keD, 'k-', k11x, k11, 'k-', k12x, k12, 'k-');
hold on;
% axis([-0.35 0.35 -0.6 0.6]);

actHysteresis = plot(hysteresis(:, 1), hysteresis(:, 2));
legend([designHysteresis(1) actHysteresis], 'Design Hysteresis', 'Actual Hysteresis', 'Location', 'northwest');
xlabel('displacement(m)');
ylabel('force(tf)');
