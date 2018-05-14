clc; clear; close all;

displacements = filename_to_array('whole-structure-v2', 2, 1, 1);

shear = filename_to_array('whole-structure', 2, 2, 1);

figure;
plot(displacements / 7000, shear);
title('whole structure');
xlabel('\theta_p (radian)');
ylabel('Base Shear (kN)');






displacements = filename_to_array('Lower-Link-v3', 2, 1, 1);

shear = filename_to_array('Lower-Link-v3', 2, 2, 1);

figure;
plot(displacements, shear, [-0.15 0.15], [1459.5318 1459.5318], 'k--', [-0.15 0.15], [-1459.5318 -1459.5318], 'k--');
text(0.05, 1200, 'Vp = 1459.5318 kN')
title('Lower Link');
xlabel('\gamma_p (radian)');
ylabel('Link Shear (kN)');





displacements = filename_to_array('Upper-Link-v3', 2, 1, 1);

shear = filename_to_array('Upper-Link-v3', 2, 2, 1);

figure;
plot(displacements, shear, [-0.15 0.15], [1053.54495 1053.54495], 'k--', [-0.15 0.15], [-1053.54495 -1053.54495], 'k--');
text(0.05, 900, 'Vp = 1053.54495 kN')
title('Upper Link');
xlabel('\gamma_p (radian)');
ylabel('Link Shear (kN)');
