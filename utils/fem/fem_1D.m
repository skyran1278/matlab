function [stiffness, force, displacements, coordinate_and_stress] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements)
%
% fem for 1D.
%
% TODO:
% 我覺得 stress 做出來的資料只能畫圖，不能用來幹甚麼，很難用很髒。
% 有點想把 stress 抓出去，不要在這裡做。
%
% @since 4.0.1
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {symfun} [A] area of cross section (m^2).
% @param {array} [L] length of bar (m).
% @param {symfun} [b] internal force.
% @param {array} [force] boundary conditions.
% @param {number} [number_elements] number of elements.
% @param {number} [number_nodes] number of nodes.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [prescribed_dof] essential boundary conditions.
% @param {array} [displacements] initial displacements.
% @return {array} [stiffness] stiffness.
% @return {array} [force] force.
% @return {array} [displacements] displacements.
% @return {array} [coordinate_and_stress] coordinate and stress, to plot.
% @see lagrange_interpolation, gauss_quadrature, solution, gauss_quadrature_curry
%

    syms xi;

    number_element_nodes = size(element_nodes, 2);

    ngp = fix(number_element_nodes / 2) + 1;

    gauss_quadrature = gauss_quadrature_curry(ngp);

    xc = linspace(-1, 1, number_element_nodes);

    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    Ke = sym(zeros(number_element_nodes, number_element_nodes));

    fe = sym(zeros(number_element_nodes, 1));

    stiffness = zeros(number_nodes, number_nodes);

    coordinate_and_stress = zeros(number_elements * number_element_nodes, 2);

    % computation of the system stiffness matrix
    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        xe = node_coordinates(elementDof).';

        J = diff_Ne * xe;

        Be = 1 / J * diff_Ne;

        fe(xi) = Ne.' * b(Ne * xe);

        Ke(xi) = Be.' * E(e) * A(Ne * xe) * Be;

        stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + simplify(J * gauss_quadrature(Ke, ngp));

        force(elementDof) = force(elementDof) + simplify(J * gauss_quadrature(fe, ngp));

    end


    % solution
    G_dof = number_nodes;
    displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


    % stress
    index_stress = 0;

    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        xe = node_coordinates(elementDof).';

        J = diff_Ne * xe;

        Be(xi) = 1 / J * diff_Ne;

        for index_xc = 1 : number_element_nodes

            index_stress = index_stress + 1;

            % x 座標
            coordinate_and_stress(index_stress, 1) = xe(index_xc);

            % y 座標
            % 我覺得 stress 做出來的資料只能畫圖，不能用來幹甚麼，很難用
            % 有點想把 stress 抓出去，不要在這裡做。
            coordinate_and_stress(index_stress, 2) = E(e) * Be(xc(index_xc)) * displacements(elementDof);

        end


    end

end


