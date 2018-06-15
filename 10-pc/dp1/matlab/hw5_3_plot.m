clc; clear; close all;

plot_timehistory('El_Centro_RF', 'El Centro')
plot_timehistory('TCU068_EW_RF', 'TCU068 EW')
plot_timehistory('TCU068_NS_RF', 'TCU068 NS')

% filename = 'El_Centro_RF';

% period = filename_to_array((filename + "_nodamper"), 3, 1, 10);
% acceleration_nodamper = filename_to_array((filename + "_nodamper"), 3, 2, 10);
% displacement_nodamper = filename_to_array((filename + "_nodamper"), 3, 3, 10);

% acceleration_l = filename_to_array(filename, 3, 2, 10);
% acceleration_1 = filename_to_array((filename + "_10000"), 3, 2, 10);
% acceleration_2 = filename_to_array((filename + "_20000"), 3, 2, 10);
% acceleration_nonl3 = filename_to_array((filename + "_l_30000"), 3, 2, 10);
% acceleration_nonl4 = filename_to_array((filename + "_l_20000"), 3, 2, 10);
% acceleration_3 = filename_to_array((filename + "_30000"), 3, 2, 10);
% acceleration_5 = filename_to_array((filename + "_50000"), 3, 2, 10);
% acceleration_10 = filename_to_array((filename + "_100000"), 3, 2, 10);
% % displacement_2 = filename_to_array(filename, 3, 3, 10);


% figure;
% plot(period, acceleration_nonl3, period, acceleration_nonl4, ':');
% xlabel('Time(sec)');
% ylabel('acceleration(m/s^2)');
% legend({'without damper', 'with damper 1', 'with damper 2', 'with damper 3', 'with damper 5', 'with damper 10'}, 'Location', 'northeast');

function [] = plot_timehistory(filename, titlename)

    period = filename_to_array(filename, 3, 1, 10);
    acceleration = filename_to_array(filename, 3, 2, 10);
    displacement = filename_to_array(filename, 3, 3, 10);

    acceleration_nodamper = filename_to_array((filename + "_nodamper"), 3, 2, 10);
    displacement_nodamper = filename_to_array((filename + "_nodamper"), 3, 3, 10);

    figure;
    plot(period, acceleration_nodamper, period, acceleration);
    title([titlename ' Roof absolute acceleration']);
    xlabel('Time(sec)');
    ylabel('acceleration(m/s^2)');
    legend({'without damper', 'with damper'}, 'Location', 'northeast');

    figure;
    plot(period, displacement_nodamper, period, displacement);
    title([titlename ' Roof relative displacement']);
    xlabel('Time(sec)');
    ylabel('displacement(m)');
    legend({'without damper', 'with damper'}, 'Location', 'northeast');

end
