function output = plot_stress(E, number_elements, element_nodes, node_coordinates, prescribed_dof, displacements)
%
% fem for 1D.
%
% TODO:
% 我覺得 stress 做出來的資料只能畫圖，不能用來幹甚麼，很難用很髒。
% 有點想把 stress 抓出去，不要在這裡做。
%
% @since 4.0.1
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {number} [number_elements] number of elements.
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

    number_element_nodes = size(element_nodes, 2);

    number_total_nodes = number_elements * number_element_nodes;

    coordinate_

    coordinate_and_stress = zeros(number_elements * number_element_nodes, 2);

    xc = linspace(-1, 1, number_element_nodes);

    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

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
