clc; clear; close all;

syms xi x0 x1 x2 a;

shape_function = lagrange_interpolation([-1 0 1], xi);

r = shape_function * [x1 - x0; x2 - x0; Inf - x0]

r = simplify(subs(r, [x1 - x0, x2 - x0, Inf - x0], [a, 2 * a, Inf]))
