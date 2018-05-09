clc; clear; close all;

x = 0: 0.001 : 2;
y = sqrt(1 ./ (1 + x));

figure;
plot(x, y);
title('T_e/T_0 vs SR_V_E');
xlabel('SR_V_E');
ylabel('T_e/T_0');

period_0 = 0.3290; % s
mass = 3.622244; % t
eta_v = 1.3281848637356404;

sr_ve = 0 : 0.01 : 8;

period_e = period_0 * sqrt(1 ./ (1 + sr_ve));

omega_r = 2 * pi / period_0;

omega_sr = 2 * pi ./ period_e;

xi_ve = eta_v ./ 2 * (1 - (omega_r ^ 2) ./ (omega_sr .^ 2));

figure;
plot(sr_ve, xi_ve);
title('\xi_V_E vs SR_V_E');
xlabel('SR_V_E');
ylabel('\xi_V_E');

