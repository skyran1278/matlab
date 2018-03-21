clc; clear; close all;

TIME_COL = 1;
ACCEL_COL = 2;
DISP_COL = 3;
BASE_COL = 4;

El50AXBS_3_fileid = fopen('El50AXBS_1.1%.txt', 'r');
El50AXBS_3 = fscanf(El50AXBS_3_fileid, '%f %f %f %f', [4 Inf]);
El50AXBS_3 = El50AXBS_3';
El50AXBS_3(:, ACCEL_COL) = El50AXBS_3(:, ACCEL_COL) / 9.81;
El50AXBS_3(:, BASE_COL) = El50AXBS_3(:, BASE_COL) / 9.81;

EL50RFA_fileid = fopen('EL50RFA.txt', 'r');
EL50RFA = fscanf(EL50RFA_fileid, '%f');

% EL50RFA_fileid = fopen('EL50RFA.txt', 'r');
% EL50RFA_fileid = fopen('EL50RFA.txt', 'r');
% EL50RFA_fileid = fopen('EL50RFA.txt', 'r');
figure(5);
cpsd(El50AXBS_3(:, TIME_COL), El50AXBS_3(:, ACCEL_COL))

figure(1);
plot((1 : length(EL50RFA)) * 0.0125, EL50RFA);
hold on;
plot(El50AXBS_3(:, TIME_COL), El50AXBS_3(:, ACCEL_COL), '--');
title('El50AXBS_3%');
xlabel('time (s)');
ylabel('Accel(g)');

[EL50RFA_freq, EL50RFA_ampl] = fft_improve(EL50RFA, 0.0125);

figure(2);
plot(EL50RFA_freq , EL50RFA_ampl);
[EL50RFA_max, EL50RFA_index] = max(EL50RFA_ampl);
1 / EL50RFA_freq(EL50RFA_index)

[El50AXBS_3_freq, El50AXBS_3_ampl] = fft_improve(El50AXBS_3(:, ACCEL_COL), 0.0125);

hold on;
plot(El50AXBS_3_freq , El50AXBS_3_ampl);
[El50AXBS_3_max, El50AXBS_3_index] = max(El50AXBS_3_ampl);
1 / El50AXBS_3_freq(El50AXBS_3_index)
title('EL50RFA Spectrum');
xlabel('f (Hz)');
ylabel('Accel(g)');

  % figure(3);

  % El50AXBS_3_fft = fft(El50AXBS_3(:, ACCEL_COL));

  % El50AXBS_3_abs = abs(El50AXBS_3_fft / length(El50AXBS_3_fft));

  % frequ = 1 / 0.0125 * (0 : length(El50AXBS_3_abs) - 1 ) / length(El50AXBS_3_abs);

  % plot(frequ, El50AXBS_3_abs);
