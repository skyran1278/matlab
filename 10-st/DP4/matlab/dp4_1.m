clc; clear; close all;

period = filename_to_array('CHY076EW', 2, 1);
CHY076EW = filename_to_array('CHY076EW', 2, 2);
CHY076SN = filename_to_array('CHY076SN', 2, 2);
period_sp = filename_to_array('CHY076SN_sp', 3, 1, 1);
CHY076SN_sp = filename_to_array('CHY076SN_sp', 3, 2, 1);
CHY076EW_sp = filename_to_array('CHY076EW_sp', 3, 2, 1);

figure;
plot(period, CHY076EW);
title('CHY076EW Ground Motion');
xlabel('T(sec)');
ylabel('Accel(g)');

figure;
plot(period, CHY076SN);
title('CHY076SN Ground Motion');
xlabel('T(sec)');
ylabel('Accel(g)');

figure;
plot(period_sp, CHY076SN_sp);
title('CHY076SN Acceleration Response Spectra \xi = 5%');
xlabel('T(sec)');
ylabel('Accel(g)');

figure;
plot(period_sp, CHY076EW_sp);
title('CHY076EW Acceleration Response Spectra \xi = 5%');
xlabel('T(sec)');
ylabel('Accel(g)');
