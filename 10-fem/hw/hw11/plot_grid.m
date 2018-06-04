function [] = plot_grid(nodes, shape_function_xi, shape_function_eta)

    if nargin == 1
        shape_function_xi = @(x) 0;
        shape_function_eta = @(x) 0;
        plot_format = 'k--';
    else
        plot_format = 'k';
    end

    natural = -1 : 0.001 : 1;

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

    plot3(x, y, z, plot_format);
    hold on;

end
