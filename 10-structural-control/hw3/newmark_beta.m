function [] = newmark_beta(filename)

    fileID = fopen([filename '.txt'], 'r');

    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

    ew_data = A(:, 4);

    ew_length = length(ew_data);

    time_interval = 0.005;

    damping_ratios = [0.02 0.05 0.1 0.2 0.4];

    damping_length = length(damping_ratios);

    tn_data = 0.1 : 0.1 : 10;
    tn_length = length(tn_data);

    sv_data = zeros(damping_length, tn_length);
    sa_data = zeros(damping_length, tn_length);
    psv_data = zeros(damping_length, tn_length);
    psa_data = zeros(damping_length, tn_length);

    % Linear Acceleration Method
    gamma_ = 1 / 2;
    beta_ = 1 / 4;

    m = 1;
    p_t = - m * ew_data;

    u = zeros(size(p_t));
    v = zeros(size(p_t));
    a = zeros(size(p_t));



    for index_1 = 1 : damping_length

        damping_ratio = damping_ratios(index_1);

        for index_2 = 1 : tn_length

            tn = tn_data(index_2);

            wn = (2 * pi) / tn;

            k = (wn ^ 2) * m;

            c = 2 * damping_ratio * wn * m;

            a(1) = 1 / m * (p_t(1) - c * v(1) - k * u(1));

            for index_3 = 2 : ew_length

                dp = p_t(index_3) - p_t(index_3 - 1);

                % k_star = k * (1 + (u(index_3 - 1) ^ 2));

                [u(index_3),v(index_3),a(index_3)] = newmark_beta_calculation(m, c, k, u(index_3 -1), v(index_3 -1), a(index_3 -1), dp, time_interval, gamma_, beta_);
            end

            a = a + ew_data;

            psv_data(index_1, index_2) = max(abs(u)) * wn;
            psa_data(index_1, index_2) = max(abs(u)) * wn ^ 2;

            % sd_data(index_1, index_2)=max(abs(u));
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
