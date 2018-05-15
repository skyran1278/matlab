function stiffness = form_stiffness_rec(G_dof, number_elements, element_nodes, node_coordinates, D, thickness)
%
% compute stiffness matrix.
% for plane stress rectangular elements.
%
% @since 1.0.0
% @param {number} [G_dof] global number of degrees of freedom.
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] �p��.
% @return {array} [stiffness] stiffness.
%

    syms xi eta;

    stiffness = zeros(G_dof);

    % �@�� element ���X�� nodes
    num_node_per_element = size(element_nodes, 2);

    % �@�� element ���X�Ӧۥѫ�
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    gauss_quadrature = gauss_quadrature_curry('2x2')

    shape = 1 / 4 * [ (1 - xi) * (1 - eta), (1 + xi) * (1 - eta), (1 + xi) * (1 + eta), (1 - xi) * (1 + eta)];

    diff_shape = 1 / 4 * [
        - (1 - eta), 1 - eta, 1 + eta, - (1 + eta);
        - (1 - xi), - (1 + xi), 1 + xi, 1 - xi;
    ];

    diff_shape_XY = zeros(size(diff_shape));

    B = sym(zeros(3, num_e_dof));

    ke = sym(zeros(num_node_per_element, num_node_per_element));

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        %
        % THIS IS A HACK: we assume node 1 and node 2 align
        % with x-axis and node 2 and node3 align with y-axis
        %
        a = 0.5 * abs(node_coordinates(element_nodes(e, 2), 1) - node_coordinates(element_nodes(e, 1), 1));

        b = 0.5 * abs(node_coordinates(element_nodes(e, 3), 2) - node_coordinates(element_nodes(e, 2), 2));

        diff_shape_XY(1, :) = 1 / a * diff_shape(1, :);
        diff_shape_XY(2, :) = 1 / b * diff_shape(2, :);

        B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
        B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
        B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
        B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

        ke(xi, eta) = thickness * a * b * B.' * D * B;

        k = gauss_quadrature(ke);

        if det(k) ~= 0
            warning('det(k) <> 0: element %d\n', e);
        end

        % stiffness matrix
        stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + k;

    end

end
