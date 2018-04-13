clc; clear; close all;

syms x xe1 xe2;

E = 1000;
A = 1;
L = 10;

number_nodes = 5;

b(x) = 10 * sin(pi * x / 10);

t_bar = 25;

number_elements = number_nodes - 1;

element_nodes = [(1 : number_nodes - 1); (2 : number_nodes)].';
node_coordinates = 0 : (L / number_elements) : L;

xe = [xe1 xe2];

Ne = sym(ones(size(xe)));

for index = 1 : length(Ne)
    xi = xe(index);
    xj = xe(xe ~= xi);
    Ne(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
end

f(x) = Ne.' * b(x);

fe_omega(xe1, xe2) = gauss_quadrature(f, xe1, xe2, 3);

fe_gamma(x, xe1, xe2) = Ne.' * A * t_bar;

force = zeros(number_nodes, 1);

for e = 1 : number_elements
    elementDof = element_nodes(e, :);
    xe = node_coordinates(elementDof);
    if xe(1) <= 5 && xe(2) <= 5
        force(elementDof) = force(elementDof) + fe_omega(xe(1), xe(2));
    elseif xe(2) == 10
        force(elementDof) = force(elementDof) + fe_gamma(10, xe(1), xe(2));
    end
end

force
