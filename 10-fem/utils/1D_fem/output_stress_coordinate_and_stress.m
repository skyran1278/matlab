function [stress_coordinate, stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, displacements)
%
% output stress coordinate and stress to plot.
%
% @since 1.0.1
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [displacements] initial displacements.
% @return {array} [stress_coordinate] stress coordinate.
% @return {array} [stress] coordinate and stress, to plot.
% @see lagrange_interpolation, gauss_quadrature, solution, gauss_quadrature_curry
%

    syms xi;

    % 一個 element 有幾個 nodes
    number_element_nodes = size(element_nodes, 2);

    % stress x 座標
    stress_coordinate = zeros(number_elements * number_element_nodes, 1);

    stress = zeros(number_elements * number_element_nodes, 1);

    % 這裡蠻重要的觀念是 xc 不是 abscissa
    % abscissa 是由 ngp 得來的，只用來計算高斯的精度
    % xc 是從 物理的 element 裡有幾個點，不管有沒有均分 (物理座標系)
    % xc 都是從 -1 ~ 1 的 均分 (xi 座標系)
    % xc 是用來得到 shape function (xi 座標系)
    xc = linspace(-1, 1, number_element_nodes);

    % shape function (xi 座標系)
    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    % stress
    index_stress = 0;

    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % 這個 element node 的座標
        xe = node_coordinates(elementDof).';

        % 計算 Jacobian 相容於 xe 不等分
        J = diff_Ne * xe;

        Be(xi) = 1 / J * diff_Ne;

        for index_xc = 1 : number_element_nodes

            index_stress = index_stress + 1;

            % x 座標
            stress_coordinate(index_stress) = xe(index_xc);

            % y 座標
            stress(index_stress) = E(e) * Be(xc(index_xc)) * displacements(elementDof);

        end

    end

end
