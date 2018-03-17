clc; clear; close all;

syms m wn t P0 tau td;

u1 = 1  / m / wn * int(P0 * sin(pi() * tau / td) * sin(wn * (t - tau)), tau, 0, t); % -(P0*td*(pi*sin(t*wn) - td*wn*sin((pi*t)/td)))/(m*wn*(td^2*wn^2 - pi^2))

u2 = 1  / m / wn * int(P0 * sin(pi() * tau / td) * sin(wn * (t - tau)), tau, 0, td); % -(P0*td*pi*(sin(t*wn) + sin(wn*(t - td))))/(m*wn*(td^2*wn^2 - pi^2))
