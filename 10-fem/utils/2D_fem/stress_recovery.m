function [stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements)
%
% stress recovery.
%
% @since 1.0.2
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {array} [displacements] displacements.
% @return {cell} [stress_gp_cell] stress on gauss point.
% @return {cell} [stress_node_cell] stress on node.
%

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    [weight, location] = gauss_const_2D('2x2');

    ngp = size(weight, 1);

    stress_gp_cell = cell(number_elements, 1);
    stress_node_cell = cell(number_elements, 1);

    recovery = [
        1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2;
        - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2;
        1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2;
        - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2;
    ];

    for e = 1 : number_elements

        for index = 1 : num_node_per_element

            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;

            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        % 這裡已經在做高斯了
        for index = 1 : ngp

            stress_gp = zeros(ngp, 3);

            xi = location(index, 1);
            eta = location(index, 2);

            % 輸出的已經是數值了
            % 只適用於 Q4
            [~, diff_shape] = shape_function_Q4(xi, eta);

            % number array
            [~, ~, diff_shape_xy] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            % 應該要拆出來比較合理，不過算了。
            % 已經是數值了
            B = zeros(3, num_e_dof);

            % x 0 x 0 ...
            B(1, 1 : 2 : num_e_dof) = diff_shape_xy(1, :);

            % 0 y 0 y ...
            B(2, 2 : 2 : num_e_dof) = diff_shape_xy(2, :);

            % y x y x ...
            B(3, 1 : 2 : num_e_dof) = diff_shape_xy(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_xy(1, :);

            stress_gp(index, :) = (D * B * displacements(element_dof, 1)).';

        end

        stress_node = recovery * stress_gp;

        stress_gp_cell{e} = stress_gp;
        stress_node_cell{e} = stress_node;

    end

end
