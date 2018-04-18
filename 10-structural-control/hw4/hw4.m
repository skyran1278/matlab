clc; clear; close all;

ag = filename_to_ag('TCU052', 4);
time = filename_to_ag('TCU052', 1);

time_interval = 0.005;

damping_ratio = 0.05;

tn = 0.1;

method = 'average';

m = 500;

c = 2 * damping_ratio * (2 * pi) / tn * m;

k = 1973921;

[u, v, a] = newmark_beta(ag, time_interval, damping_ratio, tn, method, m, c, k);

kinetic_energy = 1 / 2 * m * (v .^ 2);

potential_energy = 1 / 2 * k * (u .^ 2);

modal_damping_energy = c * (v .^ 2);

input_energy = kinetic_energy + potential_energy + modal_damping_energy;


plot(time, kinetic_energy, time, potential_energy, time, modal_damping_energy);
