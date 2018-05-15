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
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [prescribed_dof] essential boundary conditions.
% @param {array} [displacements] initial displacements.
% @param {number} [ngp] integration points，ngp >= (p + 1) / 2.
% @return {array} [stiffness] stiffness.
% @return {array} [force] force.
% @return {array} [displacements] displacements.
% @see lagrange_interpolation, gauss_quadrature, solution, gauss_quadrature_curry
%

    syms xi;

    % 一個 element 有幾個 nodes
    number_element_nodes = size(element_nodes, 2);

    % ngp 要多少 ngp >= (p + 1) / 2
    % 由於 E A 都有可能是 xi 的函數，造成 p 變大
    % 而我們目前遇到的幾乎都是一次的函數
    % 所以可以直接加 1 進行比較保險的計算
    % 也可以使用者自己指定 ngp
    if nargin == nargin('fem_1D') - 1
        ngp = ceil(number_element_nodes / 2) + 1;
    end

    % curry 回傳 gauss_quadrature 加速用
    gauss_quadrature = gauss_quadrature_curry(ngp);

    % 這裡蠻重要的觀念是 xc 不是 abscissa
    % abscissa 是由 ngp 得來的，只用來計算高斯的精度
    % xc 是從 物理的 element 裡有幾個點，不管有沒有均分 (物理座標系)
    % xc 都是從 -1 ~ 1 的 均分 (xi 座標系)
    % xc 是用來得到 shape function (xi 座標系)
    xc = linspace(-1, 1, number_element_nodes);

    % shape function (xi 座標系)
    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    Ke = sym(zeros(number_element_nodes, number_element_nodes));

    fe = sym(zeros(number_element_nodes, 1));

    stiffness = zeros(number_nodes, number_nodes);

    % computation of the system stiffness matrix
    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % 這個 element node 的座標
        xe = node_coordinates(elementDof).';

        % x 與 xi 的關係
        x = Ne * xe;

        % 相容於不連續斷面
        be = b(x);

        Ae = A(x);

        % 計算 Jacobian 相容於 xe 不等分
        J = diff_Ne * xe;

        Be = diff_Ne / J;

        fe(xi) = Ne.' * be(e);

        Ke(xi) = Be.' * E(e) * Ae(e) * Be;

        stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + simplify(gauss_quadrature(J * Ke, ngp));

        force(elementDof) = force(elementDof) + simplify(gauss_quadrature(J * fe, ngp));

    end

    % solution
    % 幾個自由度
    G_dof = number_nodes;
    displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

end


