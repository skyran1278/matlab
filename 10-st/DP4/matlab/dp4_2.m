clc; clear; close all;

period = filename_to_array('base_shaer_x', 2, 1, 1) / 160;
base_shaer_x = filename_to_array('base_shaer_x_v1', 2, 2, 1);
base_shaer_z = filename_to_array('base_shaer_z_v2', 2, 2, 1);

base_shaer_x_diff1 = abs(diff(base_shaer_x, 1));
base_shaer_x_diff2 = abs(diff(base_shaer_x, 2));
base_shaer_x_diff3 = abs(diff(base_shaer_x, 3));

% figure;
% plot(period(1 : end - 1), base_shaer_x_diff1);

% figure;
% plot(period(1 : end - 2), base_shaer_x_diff2);

% figure;
% plot(period(1 : end - 3), base_shaer_x_diff3);

design_base_shear_x = base_shaer_x(base_shaer_x_diff2 > 1);


figure;
plot(period, base_shaer_x, [0 2.5], [design_base_shear_x(1) design_base_shear_x(1)], 'k--', [0 2.5], [base_shaer_x(end) base_shaer_x(end)], 'k--', [0.25 0.25], [base_shaer_x(end), design_base_shear_x(1)], ':');
text(1, design_base_shear_x(1) - 1000, ['static LRFD design base shear = ' num2str(design_base_shear_x(1)) ' kN']);
text(1, base_shaer_x(end) + 500, ['ultimate strength = ' num2str(base_shaer_x(end)) ' kN']);
text(0.3, (base_shaer_x(end) + design_base_shear_x(1)) / 2, ['\Omega_0 = ' num2str(base_shaer_x(end) / design_base_shear_x(1))]);
title('Pushover Curve X direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');


base_shaer_z_diff1 = abs(diff(base_shaer_z, 1));
base_shaer_z_diff2 = abs(diff(base_shaer_z, 2));
base_shaer_z_diff3 = abs(diff(base_shaer_z, 3));

% figure;
% plot(period(1 : end - 1), base_shaer_z_diff1);

% figure;
% plot(period(1 : end - 2), base_shaer_z_diff2);

% figure;
% plot(period(1 : end - 3), base_shaer_z_diff3);

design_base_shear_z = base_shaer_z(base_shaer_z_diff2 > 50);

figure;
plot(period, base_shaer_z, [0 2.5], [design_base_shear_z(2) design_base_shear_z(2)], 'k--', [0 2.5], [base_shaer_z(end) base_shaer_z(end)], 'k--', [0.25 0.25], [base_shaer_z(end), design_base_shear_z(2)], ':');
text(1, design_base_shear_z(2) - 1000, ['static LRFD design base shear = ' num2str(design_base_shear_z(2)) ' kN']);
text(1, base_shaer_z(end) - 500, ['ultimate strength = ' num2str(base_shaer_z(end)) ' kN']);
text(0.3, (base_shaer_z(end) + design_base_shear_z(2)) / 2 + 1000, ['\Omega_0 = ' num2str(base_shaer_z(end) / design_base_shear_z(2))]);
title('Pushover Curve Y direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');
