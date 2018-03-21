clc; clear; close all;

El50AXBS_fileid = fopen('El50AXBS.txt', 'r');
EL50RFA_fileid = fopen('EL50RFA.txt', 'r');

El50AXBS = fscanf(El50AXBS_fileid, '%f');
EL50RFA = fscanf(EL50RFA_fileid, '%f');

[EL50RFA_freq, EL50RFA_ampl] = fft_improve(EL50RFA, 0.0125);
[El50AXBS_freq, El50AXBS_ampl] = fft_improve(El50AXBS, 0.0125);

transfer_function = EL50RFA_ampl ./ El50AXBS_ampl;

plot(El50AXBS_freq(2 : end), transfer_function(2 : end));

[transfer_function_max, transfer_function_index]=max(transfer_function(2 : end));

1 / El50AXBS_freq(transfer_function_index)

title('Transfer Function');
xlabel('f (Hz)');
ylabel('Ampli(g)');
