clc; clear; close all;

syms t tr Tn;

wn = 2 * pi() / Tn;

eqn = cos(wn * (t - tr)) - cos(wn * t) == 0;

[tm, param, cond] = solve(eqn, t, 'ReturnConditions', true); % t = tr/2 + (k*Tn)/2
