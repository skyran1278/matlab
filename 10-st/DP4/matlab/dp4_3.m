clc; clear; close all;

spectra_period = filename_to_array('spectra', 2, 1);
spectra = filename_to_array('spectra', 2, 2) / 0.32;

period_sp = filename_to_array('CHY076SN_sp', 3, 1, 1);
CHY076SN_sp = filename_to_array('CHY076SN_sp', 3, 2, 1);
CHY076EW_sp = filename_to_array('CHY076EW_sp', 3, 2, 1);

T1x = 1.0117E+000;
T2x = 3.1047E-001;
T1y = 5.0328E-001;
T2y = 1.8430E-001;

figure;
plot(spectra_period, spectra, period_sp, CHY076EW_sp, [T1x T1x], [0 4], [T2x T2x], [0 4]);
title('Response Spectrum in X Direction');
xlabel('Period(sec)');
ylabel('SaD(g)');
axis([0 3 0 4]);
legend('design spectra', '5% damping normalized response spectra', ['T1x = ' num2str(T1x)], ['T2x = ' num2str(T2x)], 'Location', 'northeast');

figure;
plot(spectra_period, spectra, period_sp, CHY076SN_sp, [T1y T1y], [0 4], [T2y T2y], [0 4]);
title('Response Spectrum in Y Direction');
xlabel('Period(sec)');
ylabel('SaD(g)');
axis([0 3 0 4]);
legend('design spectra', '5% damping normalized response spectra', ['T1y = ' num2str(T1y)], ['T2y = ' num2str(T2y)], 'Location', 'northeast');
