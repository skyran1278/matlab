function [] = duhamel_integral(filename)

    fileID = fopen([filename '.txt'], 'r');

    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

    time_data = A(:, 1);
    ew_data = A(:, 4);

    time_interval = 0.005;

    damping_ratios = [0.02 0.05 0.1 0.2 0.4];

    damping_length = length(damping_ratios);

    tn_data = 0 : 0.1 : 10;
    tn_length = length(tn_data);

    sv_data = zeros(damping_length, tn_length);
    sa_data = zeros(damping_length, tn_length);
    psv_data = zeros(damping_length, tn_length);
    psa_data = zeros(damping_length, tn_length);

    for index_1 = 1 : damping_length

        damping_ratio = damping_ratios(index_1);

        for index_2 = 1 : tn_length

            tn = tn_data(index_2);

            wn = (2 * pi) / tn;
            wd = wn * sqrt(1 - (damping_ratio ^ 2));

            hw = - 1 / wd * exp(- damping_ratio * wn * time_data) .* sin(wd * time_data);

            u = conv(ew_data, hw) * time_interval;

            diff_hw = - exp(- damping_ratio * wn * time_data) .* cos(wd * time_data);

            c = conv(ew_data, diff_hw) * time_interval;

            v = - damping_ratio * wn * u + c;

            a = - wn ^ 2 * u - 2 * damping_ratio * wn * v;

            psv_data(index_1, index_2) = max(abs(u)) * wn;
            psa_data(index_1, index_2) = max(abs(u)) * wn ^ 2;

            sv_data(index_1, index_2)=max(abs(v));
            sa_data(index_1, index_2)=max(abs(a));

        end

    end

    figure;
    plot(tn_data, sa_data);
    legend({'\xi = 2%', '\xi = 5%', '\xi = 10%', '\xi = 20%', '\xi = 40%'});
    xlabel('Period (s)');
    ylabel('Acceleration (gal)');
    title([filename ' EW dir. absolute acce. spectrim Sa']);

    figure;
    plot(tn_data, sv_data);
    legend({'\xi = 2%', '\xi = 5%', '\xi = 10%', '\xi = 20%', '\xi = 40%'});
    xlabel('Period (s)');
    ylabel('Velocity (cm / s)');
    title([filename ' EW dir. absolute vel. spectrim Sv']);

    figure;
    plot(tn_data, psa_data);
    legend({'\xi = 2%', '\xi = 5%', '\xi = 10%', '\xi = 20%', '\xi = 40%'});
    xlabel('Period (s)');
    ylabel('Acceleration (gal)');
    title([filename ' EW dir. pseudo-acce. spectrim PSa']);

    figure;
    plot(tn_data, psv_data);
    legend({'\xi = 2%', '\xi = 5%', '\xi = 10%', '\xi = 20%', '\xi = 40%'});
    xlabel('Period (s)');
    ylabel('Velocity (cm / s)');
    title([filename ' EW dir. pseudo-vel. spectrim PSv']);

end


