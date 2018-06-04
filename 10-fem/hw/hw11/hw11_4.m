clc; clear; close all;

syms xi eta; % be careful performance issue.

nodes = linspace(-1, 1, 4);
linear_nodes = linspace(-1, 1, 2);

shape_xi_l1 = lagrange_interpolation(linear_nodes, 1, xi);
shape_xi_l2 = lagrange_interpolation(linear_nodes, 2, xi);
shape_eta_l1 = lagrange_interpolation(linear_nodes, 1, eta);
shape_eta_l2 = lagrange_interpolation(linear_nodes, 2, eta);

shape_xi_1 = lagrange_interpolation(nodes, 1, xi);
shape_xi_2 = lagrange_interpolation(nodes, 2, xi);
shape_xi_3 = lagrange_interpolation(nodes, 3, xi);
shape_xi_4 = lagrange_interpolation(nodes, 4, xi);
shape_eta_1 = lagrange_interpolation(nodes, 1, eta);
shape_eta_2 = lagrange_interpolation(nodes, 2, eta);
shape_eta_3 = lagrange_interpolation(nodes, 3, eta);
shape_eta_4 = lagrange_interpolation(nodes, 4, eta);

N = sym(zeros(1, 12));

N(5)= shape_xi_2 * shape_eta_l1;
N(6)= shape_xi_3 * shape_eta_l1;

N(7)= shape_eta_2 * shape_xi_l2;
N(8)= shape_eta_3 * shape_xi_l2;

N(9)= shape_xi_3 * shape_eta_l2;
N(10) = shape_xi_2 * shape_eta_l2;

N(11) = shape_eta_3 * shape_xi_l1;
N(12) = shape_eta_2 * shape_xi_l1;

N_1 = shape_xi_l1 * shape_eta_l1;
N_2 = shape_xi_l2 * shape_eta_l1;
N_3 = shape_xi_l2 * shape_eta_l2;
N_4 = shape_xi_l1 * shape_eta_l2;

N(1) = N_1 - 2 / 3 * N(5)- 1 / 3 * N(6)- 2 / 3 * N(12) - 1 / 3 * N(11);
N(2) = N_2 - 2 / 3 * N(6)- 1 / 3 * N(5)- 2 / 3 * N(7)- 1 / 3 * N(8);
N(3) = N_3 - 2 / 3 * N(9)- 1 / 3 * N(10) - 2 / 3 * N(8)- 1 / 3 * N(7);
N(4) = N_4 - 2 / 3 * N(10) - 1 / 3 * N(9)- 2 / 3 * N(11) - 1 / 3 * N(12);

shape_accumulation(xi, eta) = sum(N);

figure;
plot_grid(nodes);

natural = -1 : 0.1 : 1;

natural_length = length(natural);

x = zeros(natural_length, natural_length);
y = zeros(natural_length, natural_length);
z = zeros(natural_length, natural_length);

for node = 1 : natural_length

    for index = 1 : natural_length
        x(index, node) = natural(node);
        y(index, node) = natural(index);
        z(index, node) = shape_accumulation(x(index, node), y(index, node));
    end

end

mesh(x, y, z);
hold on;

for node = 1 : natural_length

    for index = 1 : natural_length
        x(index, node) = natural(index);
        y(index, node) = natural(node);
        z(index, node) = shape_accumulation(x(index, node), y(index, node));
    end

end

mesh(x, y, z);
