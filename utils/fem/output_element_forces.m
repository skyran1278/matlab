function [] = output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements)
%
% output element forces.
%
% @since 1.1.2
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {symfun|array} [A] area of cross section (m^2).
% @param {array} [L] length of bar (m).
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [displacements] displacements.
% @see lagrange_interpolation, gauss_quadrature, gauss_quadrature_curry
%

    syms xi;

    % �@�� element ���X�� nodes
    number_element_nodes = size(element_nodes, 2);

    % ngp �n�h�� ngp >= (p + 1) / 2
    % �ѩ� E A �����i��O xi ����ơA�y�� p �ܤj
    % �ӧڭ̥ثe�J�쪺���O�@�������
    % �ҥH�i�H�����[ 1 �i�����O�I���p��
    ngp = ceil(number_element_nodes / 2) + 1;

    % curry �^�� gauss_quadrature �[�t��
    gauss_quadrature = gauss_quadrature_curry(ngp);

    % �o���Z���n���[���O xc ���O abscissa
    % abscissa �O�� ngp �o�Ӫ��A�u�Ψӭp�Ⱚ�������
    % xc �O�q ���z�� element �̦��X���I�A���ަ��S������ (���z�y�Шt)
    % xc ���O�q -1 ~ 1 �� ���� (xi �y�Шt)
    % xc �O�Ψӱo�� shape function (xi �y�Шt)
    xc = linspace(-1, 1, number_element_nodes);

    % shape function (xi �y�Шt)
    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    Ke = sym(zeros(number_element_nodes, number_element_nodes));

    disp('Element Forces')
    fprintf('element node_I node_J    force I     force J\n')

    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % �o�� element node ���y��
        xe = node_coordinates(elementDof).';

        % x �P xi �����Y
        x = Ne * xe;

        % �p�� Jacobian �ۮe�� xe ������
        J = diff_Ne * xe;

        Be = 1 / J * diff_Ne;

        % �P�_ A �O�_���ƭȯx�}�A���F�ۮe�󤣳s���_���һݰ����묹
        % ismatrix ����A���h�����N�|���ѡA�Pı matlab ���h�O�H�x�}��{��
        % �ҥH ismatrix �|�����D�A��� isnumeric
        if isnumeric(A)
            Ke(xi) = Be.' * E(e) * A(e) * Be;
        else
            Ke(xi) = Be.' * E(e) * A(x) * Be;
        end

        % element K
        k = simplify(J * gauss_quadrature(Ke, ngp));

        node_I = element_nodes(e, 1);

        node_J = element_nodes(e, end);

        force = simplify(k * displacements(element_nodes(e, :)));

        fprintf('%3d%6d%6d%15.4e%15.4e\n', e, node_I, node_J, force(1), force(end))
    end

end
