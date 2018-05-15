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

    fprintf('Stress\n');
    fprintf('Node           sigma_xx           sigma_yy           tau_xy\n');

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        % B matrix
        x1 = node_coordinates(element_nodes(e, 1), 1);
        y1 = node_coordinates(element_nodes(e, 1), 2);
        x2 = node_coordinates(element_nodes(e, 2), 1);
        y2 = node_coordinates(element_nodes(e, 2), 2);
        x3 = node_coordinates(element_nodes(e, 3), 1);
        y3 = node_coordinates(element_nodes(e, 3), 2);

        A = 1 / 2 * det([1 x1 y1; 1 x2 y2; 1 x3 y3]);
        B = 1 / (2 * A) .* [y2 - y3, 0, y3 - y1, 0 y1 - y2, 0; 0, x3 - x2, 0, x1 - x3, 0, x2 - x1; x3 - x2, y2 - y3, x1 - x3, y3 - y1, x2 - x1, y1 - y2];

        stress = D * B * displacements(element_dof, 1);

        fprintf('%4d%20.4e%20.4e%20.4e\n', [e; stress]);

    end


end
