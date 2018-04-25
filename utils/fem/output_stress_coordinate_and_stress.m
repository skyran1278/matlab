function [stress_coordinate, stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, displacements)
%
% output stress coordinate and stress to plot.
%
% @since 1.0.1
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [displacements] initial displacements.
% @return {array} [stress_coordinate] stress coordinate.
% @return {array} [stress] coordinate and stress, to plot.
% @see lagrange_interpolation, gauss_quadrature, solution, gauss_quadrature_curry
%

    syms xi;

    % �@�� element ���X�� nodes
    number_element_nodes = size(element_nodes, 2);

    % stress x �y��
    stress_coordinate = zeros(number_elements * number_element_nodes, 1);

    stress = zeros(number_elements * number_element_nodes, 1);

    % �o���Z���n���[���O xc ���O abscissa
    % abscissa �O�� ngp �o�Ӫ��A�u�Ψӭp�Ⱚ�������
    % xc �O�q ���z�� element �̦��X���I�A���ަ��S������ (���z�y�Шt)
    % xc ���O�q -1 ~ 1 �� ���� (xi �y�Шt)
    % xc �O�Ψӱo�� shape function (xi �y�Шt)
    xc = linspace(-1, 1, number_element_nodes);

    % shape function (xi �y�Шt)
    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    % stress
    index_stress = 0;

    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % �o�� element node ���y��
        xe = node_coordinates(elementDof).';

        % �p�� Jacobian �ۮe�� xe ������
        J = diff_Ne * xe;

        Be(xi) = 1 / J * diff_Ne;

        for index_xc = 1 : number_element_nodes

            index_stress = index_stress + 1;

            % x �y��
            stress_coordinate(index_stress) = xe(index_xc);

            % y �y��
            stress(index_stress) = E(e) * Be(xc(index_xc)) * displacements(elementDof);

        end

    end

end
