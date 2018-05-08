clc; clear; close all;

El50AXBS_fileid = fopen('ETABS/El50AXBS.txt', 'r');
EL50RFA_fileid = fopen('ETABS/EL50RFA.txt', 'r');

El50AXBS = fscanf(El50AXBS_fileid, '%f');
EL50RFA = fscanf(EL50RFA_fileid, '%f');

[EL50RFA_freq, EL50RFA_ampl] = fft_improve(EL50RFA, 0.0125);
[El50AXBS_freq, El50AXBS_ampl] = fft_improve(El50AXBS, 0.0125);

transfer_function = EL50RFA_ampl ./ El50AXBS_ampl;

plot(El50AXBS_freq(2 : end), transfer_function(2 : end));

% findpeaks(transfer_function(2 : end), El50AXBS_freq(2 : end))
[~, transfer_function_index_1]=max(transfer_function);
transfer_function(transfer_function_index_1) = -Inf;

[~, transfer_function_index_2]=max(transfer_function);

mode1 = 1 / El50AXBS_freq(transfer_function_index_2)
mode2 = 1 / El50AXBS_freq(407)

title('Transfer Function');
xlabel('f (Hz)');
ylabel('Ampli(g)');
