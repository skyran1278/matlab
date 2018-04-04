clc; clear; close all;

syms x L

p_linear = [1 x];
p_quadratic = [1 x x^2];

Me_linear = [
    1 0;
    1 L;
];

Me_quadratic = [
    1 0 0;
    1 L/2 (L/2)^2;
    1 L L^2;
];

Ne_linear = simplify(p_linear / Me_linear);
Ne_quadratic = simplify(p_quadratic / Me_quadratic);

b(x) = 2 * sin(pi / L * x);

fe_linear = simplify(int(Ne_linear.' * b(x), x, 0, L))
fe_quadratic = simplify(int(Ne_quadratic.' * b(x), x, 0, L))
