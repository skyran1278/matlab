clc; clear; close all;

centerHysteresis = xlsread('FPS_center_33.xlsx', 1, 'C:D');
cornerHysteresis = xlsread('FPS_corner_33.xlsx', 1, 'C:D');
edge1Hysteresis = xlsread('FPS_edge1_33.xlsx', 1, 'C:D');
edge2Hysteresis = xlsread('FPS_edge2_33.xlsx', 1, 'C:D');

plot(centerHysteresis(:, 1), centerHysteresis(:, 2), cornerHysteresis(:, 1), cornerHysteresis(:, 2), edge1Hysteresis(:, 1), edge1Hysteresis(:, 2), edge2Hysteresis(:, 1), edge2Hysteresis(:, 2));
legend('center', 'corner', 'edge1', 'edge2', 'Location', 'northwest');
xlabel('displacement(m)');
ylabel('force(tf)');
