clc; clear; close all;

nodes = linspace(-1, 1, 4);
linear_nodes = linspace(-1, 1, 2);

figure;
plot_grid(nodes);
plot_shape(create_shape_function(nodes, 4), create_shape_function(nodes, 1));

figure;
plot_grid(nodes);
plot_shape(create_shape_function(nodes, 4), create_shape_function(nodes, 3));

figure;
plot_grid(nodes);
plot_shape(create_shape_function(nodes, 2), create_shape_function(nodes, 3));
