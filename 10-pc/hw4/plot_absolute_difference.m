function [] = plot_absolute_difference(earthquake_name, tn)

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

    filename = [num2str(tn) '_' earthquake_name '_energy'];
    filename_abs_v = [num2str(tn) '_' earthquake_name '_abs_v'];

    % time = filename_to_array(filename, 5, 1, 12);
    potential_energy_etabs = filename_to_array(filename, 5, 3, 12);
    kinetic_energy_etabs = filename_to_array(filename, 5, 4, 12);
    modal_damping_energy_etabs = filename_to_array(filename, 5, 2, 12);
    input_energy_etabs = filename_to_array(filename, 5, 5, 12);

    abs_v_etabs = filename_to_array(filename_abs_v, 2, 2, 9);

    m = 500;

    kinetic_energy_abs_etabs = 1 / 2 * m * (abs_v_etabs .^ 2);

    input_energy_etabs = input_energy_etabs + kinetic_energy_abs_etabs - kinetic_energy_etabs;

    kinetic_energy_diff = (kinetic_energy - kinetic_energy_abs_etabs(2 : end));
    potential_energy_diff = (potential_energy - potential_energy_etabs(2 : end));
    modal_damping_energy_diff = (modal_damping_energy - modal_damping_energy_etabs(2 : end));
    input_energy_diff = (input_energy - input_energy_etabs(2 : end));

    figure;
    plot(time, kinetic_energy_diff, time, potential_energy_diff, time, modal_damping_energy_diff, time, input_energy_diff, '--');
    title([earthquake_name ', T = ' num2str(tn) ', absolute energy difference']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'northeast');
    xlabel('Time (s)');
    ylabel('Energy (newmark beta method - ETABS) (N-m^2/s^2)');
    axis([0 90 -40 40]);

end
