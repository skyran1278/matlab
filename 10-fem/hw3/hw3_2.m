clc; clear; close all;

% const
Ee = 2e7; % kN/m2
unit_weighs = 24; %kN/m3
t_bar = 20; % kN/m2

% variable
syms x xe1 xe2

Ae = x + 1;

p = [1 x];

Me = [
    1 xe1;
    1 xe2;
];

Ne = simplify(p / Me);

Be = diff(Ne, x);

Ke = simplify(int(Be.' * Ae * Ee * Be, x, xe1, xe2));

Ke1 = subs(Ke, [xe1 xe2], [0, 1])
Ke2 = subs(Ke, [xe1 xe2], [1, 2])



b(x) = unit_weighs * (x + 1);

fe_omega = simplify(int(Ne.' * b(x), x, xe1, xe2));

fe_gamma = subs(Ne.' * Ae * t_bar, x, 0);

fe1 = subs(fe_omega + fe_gamma, [xe1 xe2], [0, 1])
fe2 = subs(fe_omega, [xe1 xe2], [1, 2])
