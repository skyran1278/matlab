function stiffness = form_stiffness_2D_general(G_dof, number_elements, element_nodes, node_coordinates, D, thickness)
%
% compute stiffness matrix.
% for plane stress Q4 elements.
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

    stiffness = zeros(G_dof);

    % �@�� element ���X�� nodes
    num_node_per_element = size(element_nodes, 2);

    % �@�� element ���X�Ӧۥѫ�
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    [weight, location] = gauss_const_2D('2x2');

    ngp = size(weight, 1);

    for e = 1 : number_elements

        k = zeros(num_e_dof);

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

            [jacobian_matrix, ~, diff_shape_XY] = cal_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            B = zeros(3, num_e_dof);

            B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
            B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

            k = k + det(jacobian_matrix) * weight(index) * (thickness * B.' * D * B);

            % FIXME: �o�̥|�ˤ��J�����D�A�y�����פ��@�ˡC
            stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + det(jacobian_matrix) * weight(index) * (thickness * B.' * D * B);

        end

        if det(k) ~= 0
            warning('det(k) <> 0: element %d, det(k) = %e\n', e, det(k));
        end

        % stiffness matrix
        % stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + k;

    end

end
