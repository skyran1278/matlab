clc; clear; close all;

% syms x a b;

% f(x) = x ^ 2 + sin( x / 2);

% aaa(a, b) = gauss_quadrature(f, a, b, 3);
% double(gauss_quadrature(f, -1, 1, 3))

% double(aaa(-1, 1));

% g(x) = 1 / (1.1 + x);

% res = double(gauss_quadrature(g, 3, 7, 3))

% double(int(g, x, 3, 7))


syms x k p(k);

% p(0) == 1;
% p(1) == x;
% p(k) = (2 * k - 1) / k * x * p(k - 1) - (k - 1) / k * p(k - 2);

% for index = 3 : n
%     k = 1
% end

double(solve(legendre_poly(3) == 0))

