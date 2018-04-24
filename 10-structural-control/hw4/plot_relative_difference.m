function [] = plot_relative_difference(earthquake_name, tn)

    ag = 0.01 * filename_to_array([earthquake_name '_detrend'], 1, 1, 0);
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

    filename = [num2str(tn) '_' earthquake_name '_energy'];

    potential_energy_etabs = filename_to_array(filename, 5, 3, 12);
    kinetic_energy_etabs = filename_to_array(filename, 5, 4, 12);
    modal_damping_energy_etabs = filename_to_array(filename, 5, 2, 12);
    input_energy_etabs = filename_to_array(filename, 5, 5, 12);

    kinetic_energy_diff = (kinetic_energy - kinetic_energy_etabs(2 : end)) / kinetic_energy_etabs(2 : end);
    potential_energy_diff = (potential_energy - potential_energy_etabs(2 : end)) / potential_energy_etabs(2 : end);
    modal_damping_energy_diff = (modal_damping_energy - modal_damping_energy_etabs(2 : end)) / modal_damping_energy_etabs(2 : end);
    input_energy_diff = (input_energy - input_energy_etabs(2 : end)) / input_energy_etabs(2 : end);

    figure;
    plot(time, kinetic_energy_diff, time, potential_energy_diff, time, modal_damping_energy_diff, time, input_energy_diff, '--');
    title([earthquake_name ', T = ' num2str(tn) ', relative energy difference']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy ((newmark beta method - ETABS) / ETABS) %');

end
