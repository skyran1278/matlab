clc; clear; close all;

4782064 / (2*26*(600-26)) * (1 - 0.9 * (3800 - 0.6*250 - 0.5*0.7*600) / (1.15 * 3800));

% hw2
delta_M = 2 * 4782.064 * 2.5;

V_demand = delta_M * (1 / (0.95 * 60) - 1 / (2 * 180));

t_pz = (V_demand / (0.6*3.3*40) - 2);

% hw3
delta_M_overstrength = 1.1 * 1.5 * 2 * 4782.064 * 2.5;

V_demand_overstrength = delta_M_overstrength * (1 / (0.95 * 60) - 1 / (2 * 180));

syms x;

V_p = 0.6*3.3*40*(2+x) * (1 + 3*40*3.2^2 / (60*40*(2+x)));
eval(solve(V_p == V_demand_overstrength));

% hw4
inertia_beam = 1.26352e-3;
p1 = 120;
elastic = 2e8;
length_beam = 4;

delta_beam = p1 * length_beam^3 / (3 * elastic * inertia_beam);

syms x;

inertia_col = 9.3212e-4;
theta_col = eval(1 / (elastic * inertia_col) * 2 * int(2 * p1 * length_beam * x^2 / 3.6^2, x, 0, 1.8));
delta_col = theta_col * length_beam;
delta_total = delta_beam + delta_col;

delta_beam / delta_total;
delta_col / delta_total;

h = 3.6;
db = 0.6;
dc = 0.4;
t = 0.02;
G = elastic / 2.6;

delta_beam_detail = (2 * length_beam)^3 / (24 * elastic * inertia_beam) * p1;
delta_col_detail = (2 * length_beam)^2 * (h - db)^2 / (24 * elastic * inertia_col * h) * p1;
delta_pz = 1 / 2 * (2 * length_beam - dc) / (db * t * G) * ((2 * length_beam) / (0.95 *db) * (1 - db / h) - 1) * p1;
delta_total = delta_beam_detail + delta_col_detail + delta_pz;

delta_beam_detail / delta_total;
delta_col_detail / delta_total;
delta_pz / delta_total;
