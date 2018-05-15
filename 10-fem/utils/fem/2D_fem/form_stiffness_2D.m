function stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, number_nodes, node_coordinates, D, thickness)
%
% For the T3 element, the element stiffness matrix is Ke = tAeBeDeBe.
% compute stiffness matrix for T3 elements
%
% @since 1.0.0
% @param {number} [G_dof] global number of degrees of freedom.
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {number} [number_nodes] number of nodes.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] 厚度.
% @return {array} [stiffness] stiffness.
%

    stiffness = zeros(G_dof);

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

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

        k = A * thickness * B.' * D * B;

        if det(k) ~= 0
            warning('det(k) <> 0: element %d\n', e);
        end

        % stiffness matrix
        stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + k;

    end

end
