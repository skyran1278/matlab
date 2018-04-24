function [] = plot_relative_newmark_beta(earthquake_name, tn)

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

    figure;
    plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy, time, input_energy, '--');
    title([earthquake_name ', T = ' num2str(tn) ', relative energy, newmark beta method']);
    legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'southeast');
    xlabel('Time (s)');
    ylabel('Energy (N-m^2/s^2)');

end
