clc; clear; close all;

cornerHysteresis = xlsread('FPS_corner edge center.xlsx', 1, 'C:D');
edgeHysteresis = xlsread('FPS_corner edge center.xlsx', 1, 'G:H');
centerHysteresis = xlsread('FPS_corner edge center.xlsx', 1, 'K:L');

plot(cornerHysteresis(:, 1), cornerHysteresis(:, 2), edgeHysteresis(:, 1), edgeHysteresis(:, 2), centerHysteresis(:, 1), centerHysteresis(:, 2));
legend('FPS corner', 'FPS edge', 'FPS center', 'Location', 'southeast');
xlabel('displacement(m)');
ylabel('force(tf)');
