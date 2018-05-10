function [stiffness, force, displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements, ngp)
%
% fem for 1D.
%
% @since 7.0.1
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {array of symfun} [A] area of cross section (m^2).
% @param {array} [L] length of bar (m).
% @param {array of symfun} [b] internal force.
% @param {array} [force] boundary conditions.
% @param {number} [number_elements] number of elements.
% @param {number} [number_nodes] number of nodes.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [prescribed_dof] essential boundary conditions.
% @param {array} [displacements] initial displacements.
% @param {number} [ngp] integration points�Angp >= (p + 1) / 2.
% @return {array} [stiffness] stiffness.
% @return {array} [force] force.
% @return {array} [displacements] displacements.
% @see lagrange_interpolation, gauss_quadrature, solution, gauss_quadrature_curry
%

    syms xi;

    % �@�� element ���X�� nodes
    number_element_nodes = size(element_nodes, 2);

    % ngp �n�h�� ngp >= (p + 1) / 2
    % �ѩ� E A �����i��O xi ����ơA�y�� p �ܤj
    % �ӧڭ̥ثe�J�쪺�X�G���O�@�������
    % �ҥH�i�H�����[ 1 �i�����O�I���p��
    % �]�i�H�ϥΪ̦ۤv���w ngp
    if nargin == nargin('fem_1D') - 1
        ngp = ceil(number_element_nodes / 2) + 1;
    end

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

    fe = sym(zeros(number_element_nodes, 1));

    stiffness = zeros(number_nodes, number_nodes);

    % computation of the system stiffness matrix
    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % �o�� element node ���y��
        xe = node_coordinates(elementDof).';

        % x �P xi �����Y
        x = Ne * xe;

        % �ۮe�󤣳s���_��
        be = b(x);

        Ae = A(x);

        % �p�� Jacobian �ۮe�� xe ������
        J = diff_Ne * xe;

        Be = diff_Ne / J;

        fe(xi) = Ne.' * be(e);

        Ke(xi) = Be.' * E(e) * Ae(e) * Be;

        stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + simplify(gauss_quadrature(J * Ke, ngp));

        force(elementDof) = force(elementDof) + simplify(gauss_quadrature(J * fe, ngp));

    end

    % solution
    % �X�Ӧۥѫ�
    G_dof = number_nodes;
    displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

end


