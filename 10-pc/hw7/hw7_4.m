clc; clear; close all;

periods = filename_to_array('DA_BARE_v1', 3, 1, 10);
acce_bare = filename_to_array('DA_BARE_v1', 3, 3, 10);
disp_iso = filename_to_array('DA_ISO_v3', 3, 2, 10);
acce_iso = filename_to_array('DA_ISO_v3', 3, 3, 10);
force_hysteresis = filename_to_array('hysteresis_v2', 3, 2, 10);
disp_hysteresis = filename_to_array('hysteresis_v2', 3, 3, 10);

figure;
plot(periods, acce_bare, periods, acce_iso);
title('RF acceleration responses');
xlabel('T(sec)');
ylabel('acceleration(m/s^2)');
legend('bare frame', 'isolated structure', 'Location', 'northeast');

figure;
plot(periods, disp_iso);
title('displacement responses of isolation layer');
xlabel('T(sec)');
ylabel('displacement(m)');

figure;
plot(disp_hysteresis, force_hysteresis);
title('hysteresis loop');
xlabel('displacement(m)');
ylabel('force(tf)');
axis([-0.15 0.35 -0.4 0.6]);
