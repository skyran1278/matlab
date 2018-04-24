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
