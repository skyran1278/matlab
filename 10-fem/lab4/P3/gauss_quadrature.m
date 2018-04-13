clc; clear; close all;

syms x xe1 xe2 u(x) u(x);

E = 1000;
A = 1;
L = 10;

number_nodes = 5;

b(x) = 10 * sin(pi * x / 10);

u0 = 0;
t_bar = 25;

% linear = 2
element_node_number = 2;

% gauss_quadrature
ngp = 3;
location = [-0.7745966692 0.7745966692 0];
weight = [0.5555555556 0.5555555556 0.8888888889];

number_elements = number_nodes - 1;

element_nodes = [(1 : number_nodes - 1); (2 : number_nodes)].';
node_coordinates = 0 : (L / number_elements) : L;

Ne = sym(ones(1, element_node_number));

for index = 1 : length(Ne)
    xi = node_coordinates(index);
    xj = node_coordinates(node_coordinates ~= xi);
    Ne(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
end

Be = diff(Ne, x);

f(x) = Be.' * A * E * Be;

J = (xe2 - xe1) / 2;

I = sym(zeros(size(f)));

for index = 1 : ngp
    x_subs = (xe1 + xe2) / 2 + location(index) / 2 * (xe2 - xe1);
    I = I + weight(index) * f(x_subs);
end

Ke(xe1, xe2) = J * I;

% Ke1(xe1, xe2) = int(Be.' * A * E * Be, x, xe1, xe2);

stiffness = zeros(number_nodes, number_nodes);

for e = 1 : number_elements
    elementDof = element_nodes(e, :);
    xe = node_coordinates(elementDof);
    stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + Ke(xe(1), xe(2));
end
