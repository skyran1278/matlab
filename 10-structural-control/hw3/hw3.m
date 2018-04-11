clc; clear; close all;

fileID = fopen('TCU052.txt', 'r');

A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

time_data = A(:, 1);
ew_data = A(:, 4);

time_interval = 0.005;

damping_ratios = [0.02 0.05 0.1 0.2 0.4];

% tn = 0 : 0.01 : 10;


% wn = (2 * pi) ./ tn;
% wd = wn .* sqrt(1 - (damping_ratios .^ 2));

% hw = - 1 / wd .* exp(- damping_ratios .* wn .* time_data) .* sin(wd .* time_data);

% u = convn(ew_data, hw) * time_interval;

for index = 1 : 5

    damping_ratio = damping_ratios(index)

    for tn = 0.01 : 0.01 : 10

        wn = (2 * pi) / tn;
        wd = wn * sqrt(1 - (damping_ratio ^ 2));

        hw = - 1 / wd * exp(- damping_ratio * wn * time_data) .* sin(wd * time_data);

        u = convn(ew_data, hw) * time_interval;

    end
end
