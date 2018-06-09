clc; clear; close all;

period = filename_to_array('base_shaer_x', 2, 1, 1) / 160;
base_shaer_x = filename_to_array('base_shaer_x', 2, 2, 1);
base_shaer_z = filename_to_array('base_shaer_z', 2, 2, 1);


figure;
plot(period, base_shaer_x);
title('Pushover Curve X direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');

figure;
plot(period, base_shaer_z);
title('Pushover Curve Y direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');


