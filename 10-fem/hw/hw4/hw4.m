clc; clear; close all;

% syms x a b;

% f(x) = x ^ 2 + sin( x / 2);

% aaa(a, b) = gauss_quadrature(f, a, b, 3);
% double(gauss_quadrature(f, -1, 1, 3))

% double(aaa(-1, 1));

% g(x) = 1 / (1.1 + x);

% res = double(gauss_quadrature(g, 3, 7, 3))

% double(int(g, x, 3, 7))


syms x xe1 xe2 xe3 xe4 Le;

ngp = 3;

abscissa = double(solve(legendre_polynomials(ngp) == 0))

p(x) = legendre_polynomials(ngp - 1);

weight = double(2 * (1 - (abscissa .^ 2)) ./ ((ngp * p(abscissa)) .^ 2))

xe = [xe1; xe2; xe3; xe4];

abscissa = [- 1, - 1 / 3, 1 / 3, 1];

shape_function = shape_function_with_lagrange(abscissa);

Jacobian_(xe1, xe2, xe3, xe4) = diff(shape_function * xe, x)

Jacobian = simplify(Jacobian_(0, Le / 3, Le * 2 / 3, Le))
