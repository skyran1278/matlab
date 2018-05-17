function [] = output_stress(number_elements, element_nodes, node_coordinates, D, displacements)
%
% output stress.
%
% @since 1.0.2
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {array} [displacements] displacements.
%

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    [weight, location] = gauss_const_2D('2x2');

    location = [-1 -1; 1 -1; 1 1; -1 1];

    ngp = size(weight, 1);

    fprintf('Element Nodal Stresses\n');
    fprintf('Element  Node           Sxx               Syy                Sxy\n');

    acc_stress = zeros(3, 21);
    average_count = zeros(1, 21);

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            [~, diff_shape] = shape_function_Q4(xi, eta);

            [~, ~, diff_shape_XY] = cal_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            B = zeros(3, num_e_dof);

            B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
            B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

            stress = D * B * displacements(element_dof, 1);

            acc_stress(:, element_nodes(e, index)) = acc_stress(:, element_nodes(e, index)) + stress;

            average_count(element_nodes(e, index)) = average_count(element_nodes(e, index)) + 1;

            fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress]);

        end

    end

    fprintf('Average Nodal Stresses\n');
    fprintf('Node           Sxx               Syy                Sxy\n');

    average_stress = acc_stress ./ average_count;

    fprintf('%4d%20.4e%20.4e%20.4e\n', [(1 : 21); average_stress]);

    figure;

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        patch(node_coordinates(element_nodes(e, :), 1), node_coordinates(element_nodes(e, :), 2), average_stress(1, element_nodes(e, :)));

        hold on;

    end

    colormap jet;
    colorbar;
    title('\sigma_x_x');
    xlabel('x(mm)');
    ylabel('y(mm)');
    axis([0 60 -25 25]);

    figure;

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        for index = 1 : ngp

            xi = 0;
            eta = 0;

            [~, diff_shape] = shape_function_Q4(xi, eta);

            [~, ~, diff_shape_XY] = cal_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            B = zeros(3, num_e_dof);

            B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
            B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

            stress = D * B * displacements(element_dof, 1);

            patch(node_coordinates(element_nodes(e, :), 1), node_coordinates(element_nodes(e, :), 2), stress(1));

        hold on;

        end

    end

    colormap jet;
    colorbar;
    title('\sigma_x_x');
    xlabel('x(mm)');
    ylabel('y(mm)');
    axis([0 60 -25 25]);

end
