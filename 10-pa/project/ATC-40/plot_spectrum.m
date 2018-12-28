clc; clear; close all;

function [] = TCU068_curve()
    figure;
    hold on;
    xlabel('S_d(cm)');
    ylabel('S_a(g)');

    filename = 'TCU068';

    period = filename_to_array(filename, 2, 1); % s
    ag = filename_to_array(filename, 2, 2) / 981; % g

    tn = 0.01 : 0.01 : 5;

    tn_length = length(tn);
    acceleration = zeros(1, tn_length);

    time_interval = period(2) - period(1);

    for damping_ratio = 0.05 : 0.05 : 0.2

        for index = 1 : tn_length

            [~, ~, a_array] = newmark_beta(ag, time_interval, damping_ratio, tn(index), 'average');

            acceleration(1, index) = max(abs(a_array));

        end

        sd = period2sd(tn, acceleration);

        plot(sd, acceleration)

    end

    pushover_curve()

end

function sd = period2sd(period, acceleration)
    sd = (period .^ 2) / (4 * pi .^ 2) * acceleration;
end

function [] = pushover_curve()
    filename = 'pushover';

    sd = filename_to_array(filename, 3, 1, 2); % cm
    sa = filename_to_array(filename, 3, 2, 2); % g

    plot(sd, sa);


end
