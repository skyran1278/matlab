clc; clear; close all;

period = filename_to_array('base_shaer_x', 2, 1, 1) / 160;
base_shaer_x = filename_to_array('base_shaer_x_v1', 2, 2, 1);
base_shaer_z = filename_to_array('base_shaer_z_v2', 2, 2, 1);

base_shaer_x_diff2 = abs(diff(base_shaer_x, 2));

design_base_shear_x = base_shaer_x(base_shaer_x_diff2 > 1);


figure;
plot(period, base_shaer_x, [0 2.5], [design_base_shear_x(1) design_base_shear_x(1)], 'k--', [0 2.5], [base_shaer_x(end) base_shaer_x(end)], 'k--');
hold on;
% plot_pga(["042g_x", "033g_x", "030g_x"]);
plot_pga(["042g_x", "033g_x", "030g_x", "023g_x", "015g_x", "008g_x"]);
title('Pushover Curve X direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');


base_shaer_z_diff2 = abs(diff(base_shaer_z, 2));

design_base_shear_z = base_shaer_z(base_shaer_z_diff2 > 50);

figure;
plot(period, base_shaer_z, [0 2.5], [design_base_shear_z(2) design_base_shear_z(2)], 'k--', [0 2.5], [base_shaer_z(end) base_shaer_z(end)], 'k--');
hold on;
% plot_pga(["042g_z", "033g_z", "030g_z"]);
plot_pga(["042g_z", "033g_z", "030g_z", "023g_z", "015g_z", "008g_z"]);
title('Pushover Curve Y direction');
xlabel('Drift Ratio(%)');
ylabel('Base Shear(kN)');

function [] = plot_pga(pga_name)

    pga_length = length(pga_name);

    for index = 1 : pga_length

        drift = filename_to_array((pga_name(index) + "_deform"), 2, 2, 1) / 160;
        pga = filename_to_array(pga_name(index), 2, 2, 1);

        pga_max = max(pga);
        drift_max = max(drift);

        plot(drift_max, pga_max, 'ko');
        hold on;

    end
end
