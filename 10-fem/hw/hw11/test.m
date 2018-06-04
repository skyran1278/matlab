clc; clear; close all;
% tic;

nodes_number = 4;
nodes = linspace(-1, 1, nodes_number);

shape_function_xi = create_shape_function(nodes, 4);
shape_function_eta = create_shape_function(nodes, 1);

plot_shape(nodes);
plot_shape(nodes, shape_function_xi, shape_function_eta);

function [] = plot_shape(nodes, shape_function_xi, shape_function_eta)

    if nargin == 1
        shape_function_xi = @(x) 0;
        shape_function_eta = @(x) 0;
        plot_format = 'k--';
    else
        plot_format = 'k';
    end

    natural = -1 : 0.1 : 1;

    nodes_length = length(nodes);
    natural_length = length(natural);

    x = zeros(natural_length, nodes_length);
    y = zeros(natural_length, nodes_length);
    z = zeros(natural_length, nodes_length);

    for node = 1 : nodes_length

        for index = 1 : natural_length
            x(index, node) = nodes(node);
            y(index, node) = natural(index);
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

    plot3(x, y, z, plot_format)
    hold on;

end


% xi_length = length(xi);

% x = zeros(nodes_number, xi_length);
% y = zeros(nodes_number, xi_length);
% z = zeros(nodes_number, xi_length);

% count = 1;
% for i = 1 : nodes_number

%     a = nodes(y);

%     for x = 1 : xi_length

%         b = xi(x);

%         % z = 0;

%         f(1, count) = b;
%         f(2, count) = a;
%         % f(3, count) = z;
%         count = count + 1;
%     end

%     plot3(f(1, :), f(2, :), f(3, :), 'k--');
% end

% hold on;

% count = 1;
% for x = 1 : nodes_number

%     a = nodes(x);

%     for y = 1 : xi_length

%         b = xi(y);

%         z = 0;

%         f(1, count) = a;
%         f(2, count) = b;
%         f(3, count) = z;
%         count = count + 1;
%     end

% end

% plot3(f(1, :), f(2, :), f(3, :), 'k--');

% f = zeros(3, nodes_number * xi_length);
% count = 1;
% for y = 1 : nodes_number

%     a = nodes(y);

%     for x = 1 : xi_length

%         b = xi(x);

%         z = shape_function_xi(b) * shape_function_eta(a);

%         f(1, count) = b;
%         f(2, count) = a;
%         f(3, count) = z;
%         count = count + 1;
%     end

% end

% plot3(f(1, :), f(2, :), f(3, :), 'r');
% hold on;

% count = 1;
% for x = 1 : nodes_number

%     a = nodes(x);

%     for y = 1 : xi_length

%         b = xi(y);

%         z = shape_function_xi(a) * shape_function_eta(b);

%         f(1, count) = a;
%         f(2, count) = b;
%         f(3, count) = z;
%         count = count + 1;
%     end

% end

% plot3(f(1, :), f(2, :), f(3, :), 'b');
