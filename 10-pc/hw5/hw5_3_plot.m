clc; clear; close all;

plot_timehistory('El_Centro_RF', 'El Centro')
plot_timehistory('TCU068_EW_RF', 'TCU068 EW')
plot_timehistory('TCU068_NS_RF', 'TCU068 NS')

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
