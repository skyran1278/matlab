clc; clear; close all;

syms P1 m t wn tau k;

k = wn ^ 2 * m;

u = P1 / m / wn * int(sin(wn * (t - tau)), tau, 0, t); % -(P1*(cos(t*wn) - 1))/(m*wn^2)