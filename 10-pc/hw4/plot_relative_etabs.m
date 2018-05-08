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
