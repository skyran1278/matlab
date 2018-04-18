clc; clear; close all;

ag = filename_to_ag('TCU052', 4);
time = filename_to_ag('TCU052', 1);

time_interval = 0.005;

damping_ratio = 0.05;

tn = 0.033;

method = 'average';

wn = (2 * pi) / tn;

m = 10;
c = 2 * damping_ratio * wn * m;
k = (wn ^ 2) * m;

[u, v, a] = newmark_beta(ag, time_interval, damping_ratio, tn, method);

kinetic_energy = 1 / 2 * m * (v .^ 2);

potential_energy = 1 / 2 * k * (u .^ 2);

% FIXME: 這裡有錯，要改，看 paper。
modal_damping_energy = c * (v .^ 2);

input_energy = kinetic_energy + potential_energy + modal_damping_energy;


plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy, time, input_energy);
legend({'kinetic energy', 'potential energy', 'modal damping energy', 'input energy'}, 'Location', 'northeast');
