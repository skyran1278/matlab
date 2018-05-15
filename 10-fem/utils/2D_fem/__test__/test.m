clc; clear; close all;

tic

for index = 1 : 10
    xi = index;
    eta = -index;
    [shape, diff_shape] = shape_function_Q4(xi, eta);
    a = shape;
    b = diff_shape;
end

toc

clear; close all;

tic

syms xi eta;

shape(xi, eta) = 1 / 4 * [ (1 - xi) * (1 - eta), (1 + xi) * (1 - eta), (1 + xi) * (1 + eta), (1 - xi) * (1 + eta)];

diff_shape(xi, eta) = 1 / 4 * [
    - (1 - eta), 1 - eta, 1 + eta, - (1 + eta);
    - (1 - xi), - (1 + xi), 1 + xi, 1 - xi;
];

for index = 1 : 10
    xi = index;
    eta = -index;
    a = shape(xi, eta);
    b = diff_shape(xi, eta);
end

toc

