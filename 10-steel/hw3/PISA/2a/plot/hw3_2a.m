clc; clear; close all;


%
%
%
deformation = filename_to_array('deformation');

figure;
plot(deformation(:, 1), deformation(:, 2));

legend('modal', 'Location', 'northeast');
title('Beam Shear vs deformation');

xlabel('deformation (mm)');
ylabel('Beam Shear (kN)');


%
%
%
radian = filename_to_array('radian');

exp_radian = filename_to_array('excel-radian');

figure;
plot(radian(:, 1) * 100, radian(:, 2), exp_radian(:, 1), exp_radian(:, 2));

legend({'modal', 'experiment'}, 'Location', 'northeast');
title('Beam Shear vs \theta_t_o_t_a_l');
xlabel('\theta_t_o_t_a_l (%, radian)');
ylabel('Beam Shear (kN)');
axis([-6 6 -800 800]);


%
%
%
col_radian = filename_to_array('col-radian');

exp_col_radian = filename_to_array('excel-col-radian');

figure;
plot(col_radian(:, 1) * 100, col_radian(:, 2), exp_col_radian(:, 1), exp_col_radian(:, 2));

legend({'modal', 'experiment'}, 'Location', 'northeast');
title('Beam Shear vs \theta_c');

xlabel('\theta_c (%, radian)');
ylabel('Beam Shear (kN)');
axis([-6 6 -800 800]);


%
%
%
pz_radian = filename_to_array('pz-radian');

exp_pz_radian = filename_to_array('excel-pz-radian');

figure;
plot(-pz_radian(:, 1) * 100, pz_radian(:, 2), exp_pz_radian(:, 1), exp_pz_radian(:, 2));

legend({'modal', 'experiment'}, 'Location', 'northeast');
title('Beam Shear vs \theta_p_z');

xlabel('\theta_p_z (%, radian)');
ylabel('Beam Shear (kN)');
axis([-6 6 -800 800]);


%
%
%
beam_radian(:, 2) = pz_radian(:, 2);
beam_radian(:, 1) = radian(:, 1) - col_radian(:, 1) + pz_radian(:, 1);

exp_beam_radian = filename_to_array('excel-beam-radian');

figure;
plot(beam_radian(:, 1) * 100, beam_radian(:, 2), exp_beam_radian(:, 1), exp_beam_radian(:, 2));
title('Beam Shear vs \theta_b_e_a_m');

legend({'modal', 'experiment'}, 'Location', 'northeast');

xlabel('\theta_b_e_a_m (%, radian)');
ylabel('Beam Shear (kN)');
axis([-6 6 -800 800]);
