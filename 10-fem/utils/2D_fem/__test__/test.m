clc; clear; close all;

% tic
x = -1:0.01:1;
y = [-1; 0; 1]*ones(1,length(x));

xi = [y; x; x; x]';
eta = [x; x; x; y]';
shape_function = lagrange(16);

[shape] = shape_function(xi, eta)
% for index = 1 : 10
%     xi = index;
%     eta = -index;
%     [shape, diff_shape] = shape_function_Q4(xi, eta);
%     a = shape;
%     b = diff_shape;
% end

% toc

% clear; close all;

% tic

% syms xi eta;

% shape(xi, eta) = 1 / 4 * [ (1 - xi) * (1 - eta), (1 + xi) * (1 - eta), (1 + xi) * (1 + eta), (1 - xi) * (1 + eta)];

% diff_shape(xi, eta) = 1 / 4 * [
%     - (1 - eta), 1 - eta, 1 + eta, - (1 + eta);
%     - (1 - xi), - (1 + xi), 1 + xi, 1 - xi;
% ];

% for index = 1 : 10
%     xi = index;
%     eta = -index;
%     a = shape(xi, eta);
%     b = diff_shape(xi, eta);
% end

% toc
corner_coordinates = [0 0; 5 0; 5 0.5; 0 0.5;];
x_mesh = 5;
y_mesh = 1;
[number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q8(corner_coordinates, x_mesh, y_mesh, 'along boundary')

