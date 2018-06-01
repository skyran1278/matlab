function [stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements)
%
% stress recovery.
%
% @since 1.0.3
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [D] 2D matrix D.
% @param {array} [displacements] displacements.
% @return {cell} [stress_gp_cell] stress on gauss point.
% @return {cell} [stress_node_cell] stress on node.
%

    % �@�� element ���X�� nodes
    num_node_per_element = size(element_nodes, 2);

    shape_function = create_shape_function(num_node_per_element);
    [weight, location] = gauss_2D(num_node_per_element);
    ngp = size(weight, 1);

    % �@�� element ���X�Ӧۥѫ�
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    stress_gp_cell = cell(number_elements, 2);
    stress_node_cell = cell(number_elements, 1);

    % recovery = [
    %     1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2;
    %     - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2;
    %     1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2;
    %     - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2;
    % ];

    for e = 1 : number_elements

        for index = 1 : num_node_per_element

            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;

            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        stress_gp = zeros(ngp, 3);
        stress_gp_location = zeros(ngp, 2);

        % �o�̤w�g�b�������F
        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            % ��X���w�g�O�ƭȤF
            [shape, diff_shape] = shape_function(xi, eta);

            % number array
            [~, ~, diff_shape_xy] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            % ���ӭn��X�Ӥ���X�z�A���L��F�C
            % �w�g�O�ƭȤF
            B = zeros(3, num_e_dof);

            % x 0 x 0 ...
            B(1, 1 : 2 : num_e_dof) = diff_shape_xy(1, :);

            % 0 y 0 y ...
            B(2, 2 : 2 : num_e_dof) = diff_shape_xy(2, :);

            % y x y x ...
            B(3, 1 : 2 : num_e_dof) = diff_shape_xy(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_xy(1, :);

            stress_gp(index, :) = (D * B * displacements(element_dof, 1)).';
            stress_gp_location(index, :) = shape * node_coordinates(element_nodes(e, :), :);

        end

        % stress_node = recovery * stress_gp;

        stress_gp_cell{e, 1} = stress_gp;
        stress_gp_cell{e, 2} = stress_gp_location;
        % stress_node_cell{e} = stress_node;

    end

end
