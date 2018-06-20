clc; clear; close all;

centerHysteresis = xlsread('FPS_center.xlsx', 1, 'C:D');
FNAHysteresis = xlsread('FPS_FNA.xlsx', 1, 'C:D');
% edge1Hysteresis = xlsread('FPS_edge1.xlsx', 1, 'C:D');
% edge2Hysteresis = xlsread('FPS_edge2.xlsx', 1, 'C:D');

plot(centerHysteresis(:, 1), centerHysteresis(:, 2), FNAHysteresis(:, 1), FNAHysteresis(:, 2));
legend('center', 'FNA');
xlabel('displacement(m)');
ylabel('force(tf)');
