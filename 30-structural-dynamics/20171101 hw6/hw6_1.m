clc; clear; close all;

syms t;

w = 40; % lb
m = w / 386; % lb * sec ^ 2 / in
k = 100; % lb / in
xi = 0.05;
v = 150; % in / sec
g = 386; % in / sec ^ 2
wn = sqrt(k / m); % rad / sec
wd = sqrt(1 - xi ^ 2) * wn; % rad / sec
c = 2 * wn * m * xi;

u = m * g / k + exp(- xi * wn * t) * (- m * g / k * cos(wd * t) + 1 / wd * (v - xi * wn * m * g / k ) * sin(wd * t));

pt = k * u + c * diff(u);

eqn = diff(pt) == 0;

double(solve(eqn, t)); % -0.0528 0.0485

double(subs(pt, t, 0.0485)); % 487.5348