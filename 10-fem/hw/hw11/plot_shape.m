function [] = plot_shape(shape_function_xi, shape_function_eta)

    natural = -1 : 0.001 : 1;

    natural_length = length(natural);

    x = zeros(natural_length, natural_length);
    y = zeros(natural_length, natural_length);
    z = zeros(natural_length, natural_length);

    for node = 1 : natural_length

        for index = 1 : natural_length
            x(index, node) = natural(node);
            y(index, node) = natural(index);
            z(index, node) = shape_function_xi(x(index, node)) * shape_function_eta(y(index, node));
        end

    end

    mesh(x, y, z);
    hold on;

    for node = 1 : natural_length

        for index = 1 : natural_length
            x(index, node) = natural(index);
            y(index, node) = natural(node);
            z(index, node) = shape_function_xi(x(index, node)) * shape_function_eta(y(index, node));
        end

    end

    mesh(x, y, z);
    hold on;

end
