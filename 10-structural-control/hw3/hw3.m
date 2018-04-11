clc; clear; close all;

fileID = fopen('TCU052.txt', 'r');

A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

time_data = A(:, 1);
ew_data = A(:, 4);

time_interval = 0.005;

damping_ratios = [0.02 0.05 0.1 0.2 0.4];

tn_data = 0 : 0.1 : 10;
tn_length = length(tn_data);
p_sa = zeros(tn_length, 1);
sa = zeros(tn_length, 1);

for damping_index = 1 : 5

    damping_ratio = damping_ratios(damping_index);

    for tn_index = 1 : tn_length

        tn = tn_data(tn_index);

        wn = (2 * pi) / tn;
        wd = wn * sqrt(1 - (damping_ratio ^ 2));

        hw = - 1 / wd * exp(- damping_ratio * wn * time_data) .* sin(wd * time_data);

        u = conv(ew_data, hw) * time_interval;

        diff_hw = - exp(- damping_ratio * wn * time_data) .* cos(wd * time_data);

        c = conv(ew_data, diff_hw) * time_interval;

        v = - damping_ratio * wn * u + c;

        a = - wn ^ 2 * u - 2 * damping_ratio * wn * v;
        p_sa()

    end
end
