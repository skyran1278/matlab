clc; clear; close all;
% tic;

nodes = linspace(-1, 1, 4);

figure;
plot_shape(nodes);
plot_shape(nodes, create_shape_function(nodes, 4), create_shape_function(nodes, 1));

figure;
plot_shape(nodes);
plot_shape(nodes, create_shape_function(nodes, 4), create_shape_function(nodes, 3));

figure;
plot_shape(nodes);
plot_shape(nodes, create_shape_function(nodes, 2), create_shape_function(nodes, 3));

figure;
plot_shape(nodes);
plot_shape(nodes, create_shape_function([-1 1], 2), create_shape_function(nodes, 2));

figure;
plot_shape(nodes);

l_1 = create_shape_function([-1 1], 1);
l_4 = create_shape_function([-1 1], 4);

l_2 = create_shape_function(nodes, 2);
l_3 = create_shape_function(nodes, 3);


natural = -1 : 0.01 : 1;

nodes_length = length(nodes);
natural_length = length(natural);

x = zeros(natural_length, nodes_length);
y = zeros(natural_length, nodes_length);
z = zeros(natural_length, nodes_length);

for node = 1 : nodes_length

    for index = 1 : natural_length
        x(index, node) = nodes(node);
        y(index, node) = natural(index);
        N_1 = shape_function_xi(x(index, node)) * shape_function_eta(y(index, node));

        z(index, node) = shape_function_xi(x(index, node)) * shape_function_eta(y(index, node));
    end

end

plot3(x, y, z, plot_format);
hold on;

for node = 1 : nodes_length

    for index = 1 : natural_length
        x(index, node) = natural(index);
        y(index, node) = nodes(node);
        z(index, node) = shape_function_xi(x(index, node)) * shape_function_eta(y(index, node));
    end

end

plot3(x, y, z, plot_format);
hold on;

