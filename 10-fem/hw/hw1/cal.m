clc; clear; close all;

syms a0 a1 b0 b1 x

u = x * (1 - x) * (a0 + a1 * x);
w = x * (1 - x) * (b0 + b1 * x);
du = simplify(diff(u));
dw = simplify(diff(w));

simplify(int(du * dw, x, 0, 1))
simplify(int(w * x^2, x, 0, 1))

eqns = [20 * a0 + 10 * a1 - 3 == 0, 10 * a0 + 8 * a1 - 3 == 0];
[a0, a1] = solve(eqns, [a0 a1]);

u = x * (1 - x) * (a0 + a1 * x);
simplify(diff(u));
