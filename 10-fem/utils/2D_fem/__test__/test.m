clc; clear; close all;
tic;
nodes_number = 4;

shape_function_xi = create_shape_function(nodes_number, 4);
shape_function_eta = create_shape_function(nodes_number, 1);

xi = -1 : 0.001 : 1;
eta = -1 : 0.001 : 1;

nodes = length(xi);

plot3D = zeros(nodes);

xy = meshgrid(xi, eta);

plot3(xy, xy.', plot3D);
% z = 1;
% for x = 1 : nodes

%     for y = 1 : nodes

%         plot3D(1, z) = 1;
%         hold on;
%         z = z + 1;

%     end

% end

plot_shape_function = zeros(3, 2 * nodes);
z = 1;
for x = 1
    for y = 1 : nodes
        plot_shape_function(1, z) = xi(x);
        plot_shape_function(2, z) = eta(y);
        plot_shape_function(3, z) = shape_function_xi(xi(x)) * shape_function_eta(eta(y));
        z = z + 1;
    end
end

for y = 1
    for x = 1 : nodes
        plot_shape_function(1, z) = xi(x);
        plot_shape_function(2, z) = eta(y);
        plot_shape_function(3, z) = shape_function_xi(xi(x)) * shape_function_eta(eta(y));
        z = z + 1;
    end
end

plot3(plot_shape_function(1, :), plot_shape_function(2, :), plot_shape_function(3, :));
toc
% syms xi eta; % be careful performance issue.


% [x, ~] = lagrange_interpolation(4, xi);

% [y, ~] = lagrange_interpolation(4, eta);

% x(1) .* y(-1)
% tic
% x = -1:0.01:1;
% y = [-1; 0; 1]*ones(1,length(x));

% xi = [y; x; x; x]';
% eta = [x; x; x; y]';
% shape_function = lagrange(16);

% [shape] = shape_function(xi, eta)
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
% corner_coordinates = [0 0; 5 0; 5 0.5; 0 0.5;];
% x_mesh = 5;
% y_mesh = 1;
% [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q8(corner_coordinates, x_mesh, y_mesh, 'along boundary')

