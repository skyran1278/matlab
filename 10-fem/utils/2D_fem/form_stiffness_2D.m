function stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness)
%
% compute stiffness matrix.
% for plane stress Q4 elements.
%
% @since 1.1.1
% @param {number} [G_dof] global number of degrees of freedom.
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] 厚度.
% @return {array} [stiffness] stiffness.
%

    stiffness = zeros(G_dof);

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    shape_function = create_shape_function(num_node_per_element);
    [weight, location] = gauss_2D(num_node_per_element);
    ngp = size(weight, 1);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    for e = 1 : number_elements

        k = zeros(num_e_dof);

        for index = 1 : num_node_per_element

            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;

            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        % 這裡已經在做高斯了
        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            % 輸出的已經是數值了
            [~, diff_shape] = shape_function(xi, eta);

            % number array
            [jacobian_matrix, ~, diff_shape_xy] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            % 應該要拆出來比較合理，不過算了。
            % 已經是數值了
            B = zeros(3, num_e_dof);

            % x 0 x 0 ...
            B(1, 1 : 2 : num_e_dof) = diff_shape_xy(1, :);

            % 0 y 0 y ...
            B(2, 2 : 2 : num_e_dof) = diff_shape_xy(2, :);

            % y x y x ...
            B(3, 1 : 2 : num_e_dof) = diff_shape_xy(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_xy(1, :);

            k = k + det(jacobian_matrix) * weight(index) * (thickness * B.' * D * B);

            % FIXME: 這裡四捨五入的問題，造成答案不一樣。
            stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + det(jacobian_matrix) * weight(index) * (thickness * B.' * D * B);

        end

        % k 不為 0
        % 因為 K 已經無法 exact 了
        % if det(k) ~= 0
        %     warning('det(k) <> 0: element %d, det(k) = %e\n', e, det(k));
        % end

        % stiffness matrix
        % stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + k;

    end

end
