clc; clear; close all;

% output_timehistory(1);
% output_timehistory(0.3);
% output_TCU068_ADRS_curves(1);
output_TCU068_ADRS_curves(0.4);
output_TCU068_ADRS_curves(0.5);
% output_design_ADRS_curves();
% output_service_ADRS_curves();

function [] = output_timehistory(scaled_factor)
    filename = 'TCU068';

    period = filename_to_array(filename, 2, 1); % s
    ag = filename_to_array(filename, 2, 2) / 981 * scaled_factor; % g

    fileID = fopen(['TCU068_g_', num2str(scaled_factor), '.txt'], 'w');
    fprintf(fileID,'%.3f\t%.6f\r\n', [period ag].');
    fclose(fileID);
end

function [] = output_TCU068_ADRS_curves(scaled_factor)
    filename = 'TCU068';

    period = filename_to_array(filename, 2, 1); % s
    ag = filename_to_array(filename, 2, 2) / 981 * scaled_factor; % g

    tn = 0.01 : 0.01 : 3;

    tn_length = length(tn);
    displacement = zeros(1, tn_length);
    acceleration = zeros(1, tn_length);

    time_interval = period(2) - period(1);

    for damping_ratio = 0.05 : 0.01 : 0.2

        for index = 1 : tn_length

            [u_array, ~, a_array] = newmark_beta(ag, time_interval, damping_ratio, tn(index), 'average');

            displacement(1, index) = max(abs(u_array));
            acceleration(1, index) = max(abs(a_array));

        end

        displacement = displacement * 981;

        fileID = fopen(['TCU068_scaled_factor=', num2str(scaled_factor),'_damping_ratio=', num2str(damping_ratio), '.txt'], 'w');
        fprintf(fileID,'%.4f\t%.6f\t%.3f\r\n', [displacement; acceleration; tn]);
        fclose(fileID);

    end

end

function [] = output_design_ADRS_curves()

    for damping_ratio = 0.05 : 0.01 : 0.2
        [sd, sa, tn] = output_design_ADRS_curve(1.096, 0.7776, damping_ratio);

        fileID = fopen(['design_damping_ratio=', num2str(damping_ratio), '.txt'], 'w');
        fprintf(fileID,'%.4f\t%.6f\t%.3f\r\n', [sd; sa; tn]);
        fclose(fileID);

    end

end

function [] = output_service_ADRS_curves()

    for damping_ratio = 0.05 : 0.01 : 0.2
        [sd, sa, tn] = output_design_ADRS_curve(0.8 / 3, 0.18, damping_ratio);

        fileID = fopen(['service_damping_ratio=', num2str(damping_ratio), '.txt'], 'w');
        fprintf(fileID,'%.4f\t%.6f\t%.3f\r\n', [sd; sa; tn]);
        fclose(fileID);
    end

end

function [sd, sa, tn] = output_design_ADRS_curve(SDS, SD1, damping_ratio)

    [BS, B1] = damping_factor(damping_ratio);

    T0 = SD1 * BS / (SDS * B1);
    % T0 = SD1 / (SDS);

    tn = 0.01 : 0.01 : 3;

    tn_length = length(tn);
    sa = zeros(1, tn_length);

    for index = 1 : tn_length
        T = tn(index);

        if T <= 0.2 * T0
            sa(1, index) = SDS * (0.4 + (1 / BS - 0.4) * T / (0.2 * T0));

        elseif T > (0.2 * T0) && T <= T0
            sa(1, index) = SDS / BS;

        elseif T > T0 && T <= 2.5 * T0
            sa(1, index) = SD1 / (B1 * T);

        else
            sa(1, index) = 0.4 * SDS / BS;

        end
    end

    sd = period2sd(tn, sa);

end

function sd = period2sd(period, acceleration)
    sd = (period .^ 2) / (4 * pi .^ 2) .* acceleration * 981;
end

function [BS, B1] = damping_factor(damping_ratio)
    if damping_ratio <= 0.02
        BS = 0.8;
        B1 = 0.8;

    elseif 0.02 < damping_ratio && damping_ratio <= 0.05
        BS = (damping_ratio - 0.02) / 0.03 * (1 - 0.8) + 0.8;
        B1 = (damping_ratio - 0.02) / 0.03 * (1 - 0.8) + 0.8;

    elseif 0.05 < damping_ratio && damping_ratio <= 0.1
        BS = (damping_ratio - 0.05) / 0.05 * (1.33 - 1) + 1;
        B1 = (damping_ratio - 0.05) / 0.05 * (1.25 - 1) + 1;

    elseif 0.1 < damping_ratio && damping_ratio <= 0.2
        BS = (damping_ratio - 0.1) / 0.1 * (1.6 - 1.33) + 1.33;
        B1 = (damping_ratio - 0.1) / 0.1 * (1.5 - 1.25) + 1.25;

    elseif 0.2 < damping_ratio && damping_ratio <= 0.3
        BS = (damping_ratio - 0.2) / 0.1 * (1.79 - 1.6) + 1.6;
        B1 = (damping_ratio - 0.2) / 0.1 * (1.63 - 1.5) + 1.5;

    elseif 0.3 < damping_ratio && damping_ratio <= 0.4
        BS = (damping_ratio - 0.3) / 0.1 * (1.87 - 1.79) + 1.79;
        B1 = (damping_ratio - 0.3) / 0.1 * (1.7 - 1.63) + 1.63;

    elseif 0.4 < damping_ratio && damping_ratio <= 0.5
        BS = (damping_ratio - 0.4) / 0.1 * (1.93 - 1.87) + 1.87;
        B1 = (damping_ratio - 0.4) / 0.1 * (1.75 - 1.7) + 1.7;

    elseif 0.5 < damping_ratio
        BS = 1.93;
        B1 = 1.75;

    end
end
