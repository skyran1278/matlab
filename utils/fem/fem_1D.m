function [displacements, stiffness, force] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof)
%
% fem for 1D.
%
% @since 1.1.0
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {array} [A] area of cross section (m^2).
% @param {array} [L] length of bar (m).
% @param {symfun} [b] internal force.
% @param {array} [force] boundary conditions.
% @param {number} [number_elements] number of elements.
% @param {number} [number_nodes] number of nodes.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [prescribed_dof] essential boundary conditions.
% @return {array} [displacements] displacements.
% @return {array} [stiffness] stiffness.
% @return {array} [force] force.
% @see lagrange_interpolation, gauss_quadrature, solution
%

    syms xi;

    number_element_nodes = length(element_nodes);

    ngp = fix(number_element_nodes / 2) + 1;

    Ne = lagrange_interpolation(linspace(-1, 1, number_element_nodes), xi);

    Ke = sym(zeros(number_element_nodes, number_element_nodes));

    fe = sym(zeros(number_element_nodes, 1));

    stiffness = zeros(number_nodes, number_nodes);

    % computation of the system stiffness matrix
    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        xe = node_coordinates(elementDof).';

        J = diff(Ne) * xe;

        Be = 1 / J * diff(Ne);

        fe(xi) = Ne.' * b(Ne * xe);

        Ke(xi) = Be.' * E(e) * A(e) * Be;

        stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + J * gauss_quadrature(Ke, ngp);

        force(elementDof) = force(elementDof) + J * gauss_quadrature(fe, ngp);

    end

    % solution
    G_dof = number_nodes;
    displacements = solution(G_dof, prescribed_dof, stiffness, force);

end


