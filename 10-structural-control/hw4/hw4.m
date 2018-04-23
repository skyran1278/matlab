clc; clear; close all;

plot_relative_newmark_beta('TCU052', 1);
plot_relative_etabs('TCU052', 1);
plot_absolute_newmark_beta('TCU052', 1);
plot_absolute_etabs('TCU052', 1);
plot_relative_newmark_beta('TCU072', 1);
plot_relative_etabs('TCU072', 1);
plot_absolute_newmark_beta('TCU072', 1);
plot_absolute_etabs('TCU072', 1);
fclose('all');
% ag = filename_to_array('TCU072', 4, 4, 11);

% ag_detrend = detrend(ag);

% fileID = fopen('TCU072_detrend.txt', 'w');

% fprintf(fileID, '%f\n', ag_detrend);

function [] = plot_relative_newmark_beta(earthquake_name, tn)

    ag = 0.01 * filename_to_array([earthquake_name '_ETABS'], 1, 1, 0);
    time = filename_to_array(earthquake_name, 4, 1, 11);

    time_interval = 0.005;

    damping_ratio = 0.05;

    wn = (2 * pi) / tn;

    m = 500;
    c = 2 * damping_ratio * wn * m;
    k = (wn ^ 2) * m;

    [u, v, ~] = newmark_beta(ag, time_interval, damping_ratio, tn, 'average');

    kinetic_energy = 1 / 2 * m * (v .^ 2);

    potential_energy = 1 / 2 * k * (u .^ 2);

    modal_damping_energy = cumsum(c * (v .^ 2) * time_interval);

    input_energy = kinetic_energy + potential_energy + modal_damping_energy;

    figure;
    plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy, time, input_energy, '--');
    title([earthquake_name ', T = ' num2str(tn) ', relative energy, newmark beta method']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy (N-m^2/s^2)');

end


function [] = plot_absolute_newmark_beta(earthquake_name, tn)

    ag = 0.01 * filename_to_array([earthquake_name '_detrend'], 1, 1, 0);
    time = filename_to_array(earthquake_name, 4, 1, 11);

    time_interval = 0.005;

    damping_ratio = 0.05;

    wn = (2 * pi) / tn;

    m = 500;
    c = 2 * damping_ratio * wn * m;
    k = (wn ^ 2) * m;

    [u, v, ~] = newmark_beta(ag, time_interval, damping_ratio, tn, 'average');

    abs_v = v + cumsum([0; (ag(1 : end - 1) + ag(2 : end)) / 2 * time_interval]);

    kinetic_energy = 1 / 2 * m * (abs_v .^ 2);

    potential_energy = 1 / 2 * k * (u .^ 2);

    modal_damping_energy = cumsum(c * (v .^ 2) * time_interval);

    input_energy = kinetic_energy + potential_energy + modal_damping_energy;

    figure;
    plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy, time, input_energy, '--');
    title([earthquake_name ', T = ' num2str(tn) ', absolute energy, newmark beta method']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy (N-m^2/s^2)');

end


function [] = plot_relative_etabs(earthquake_name, tn)

    filename = [num2str(tn) '_' earthquake_name '_energy'];

    time = filename_to_array(filename, 5, 1, 12);
    potential_energy = filename_to_array(filename, 5, 3, 12);
    kinetic_energy = filename_to_array(filename, 5, 4, 12);
    modal_damping_energy = filename_to_array(filename, 5, 2, 12);
    input_energy = filename_to_array(filename, 5, 5, 12);

    figure;
    plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy, time, input_energy, '--');
    title([earthquake_name ', T = ' num2str(tn) ', relative energy, ETABS']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy (N-m^2/s^2)');

end


function [] = plot_absolute_etabs(earthquake_name, tn)

    filename = [num2str(tn) '_' earthquake_name '_energy'];
    filename_abs_v = [num2str(tn) '_' earthquake_name '_abs_v'];

    time = filename_to_array(filename, 5, 1, 12);
    potential_energy = filename_to_array(filename, 5, 3, 12);
    kinetic_energy = filename_to_array(filename, 5, 4, 12);
    modal_damping_energy = filename_to_array(filename, 5, 2, 12);
    input_energy = filename_to_array(filename, 5, 5, 12);

    abs_v = filename_to_array(filename_abs_v, 2, 2, 9);

    m = 500;

    kinetic_energy_abs = 1 / 2 * m * (abs_v .^ 2);

    input_energy = input_energy + kinetic_energy_abs - kinetic_energy;

    figure;
    plot(time, kinetic_energy_abs, time, potential_energy, time, modal_damping_energy, time, input_energy, '--');
    title([earthquake_name ', T = ' num2str(tn) ', absoulte energy, ETABS']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy (N-m^2/s^2)');

end

