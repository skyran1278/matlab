function [] = output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements)
%
% output element forces.
%
% @since 1.1.2
% @param {array} [E] modulus of elasticity (N/m^2).
% @param {symfun|array} [A] area of cross section (m^2).
% @param {array} [L] length of bar (m).
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [displacements] displacements.
% @see lagrange_interpolation, gauss_quadrature, gauss_quadrature_curry
%

    syms xi;

    % 一個 element 有幾個 nodes
    number_element_nodes = size(element_nodes, 2);

    % ngp 要多少 ngp >= (p + 1) / 2
    % 由於 E A 都有可能是 xi 的函數，造成 p 變大
    % 而我們目前遇到的都是一次的函數
    % 所以可以直接加 1 進行比較保險的計算
    ngp = ceil(number_element_nodes / 2) + 1;

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

    disp('Element Forces')
    fprintf('element node_I node_J    force I     force J\n')

    for e = 1 : number_elements

        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);

        % 這個 element node 的座標
        xe = node_coordinates(elementDof).';

        % x 與 xi 的關係
        x = Ne * xe;

        % 計算 Jacobian 相容於 xe 不等分
        J = diff_Ne * xe;

        Be = 1 / J * diff_Ne;

        % 判斷 A 是否為數值矩陣，為了相容於不連續斷面所需做的犧牲
        % ismatrix 不行，有多項的就會失敗，感覺 matlab 底層是以矩陣實現的
        % 所以 ismatrix 會有問題，改用 isnumeric
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
