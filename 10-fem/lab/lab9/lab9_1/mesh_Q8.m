function [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q8(corner_coordinates, x_mesh, y_mesh, schemes)
%
% for T9 auto mesh.
%
% @since 1.0.0
% @param {array} [corner_coordinates] corner coordinates 由左至右 由下至上.
% @param {number} [x_mesh] x 方向切幾份.
% @param {number} [y_mesh] y 方向切幾份.
% @param {string} [schemes] corner first or along boundary.
% @return {number} [number_elements] number of elements.
% @return {number} [number_nodes] number of nodes.
% @return {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @return {array} [node_coordinates] 節點位置.
% @return {array} [nodes] 編號形狀位置，實際位置.
% @return {array} [flip_nodes] 編號形狀位置，正的排序.
%

    x_nodes = 2 * x_mesh + 1;
    y_nodes = 2 * y_mesh + 1;

    number_elements = x_mesh * y_mesh;
    number_nodes = x_nodes * y_nodes - number_elements;

    element_nodes = zeros(number_elements, 8);
    node_coordinates = zeros(number_nodes, 2);

    % 正的排序，方便輸出 element_nodes
    % example:
    %  1     2     3     4     5     6     7
    %  8     0     9     0    10     0    11
    % 12    13    14    15    16    17    18
    flip_nodes = zeros(y_nodes, x_nodes);

    edge_line = 1 : x_nodes;
    center_line = (1 + x_nodes) : (x_mesh + 1 + x_nodes);

    for y_node = 1 : y_nodes

        if mod(y_node, 2) ~= 0

            flip_nodes(y_node, :) = edge_line;

            edge_line = edge_line + x_mesh + 1 + x_nodes;

        else

            flip_nodes(y_node, 1 : 2 : x_nodes) = center_line;

            center_line = center_line + x_mesh + 1 + x_nodes;

        end

    end

    % 我要的的排序
    % example:
    % 12    13    14    15    16    17    18
    %  8     0     9     0    10     0    11
    %  1     2     3     4     5     6     7
    nodes = flip(flip_nodes, 1);

    e = 1;

    for y = 1 : 2 : y_nodes - 2

        for x = 1 : 2 : x_nodes - 2

            corner_1 = flip_nodes(y, x);
            corner_2 = flip_nodes(y, x + 2);
            corner_3 = flip_nodes(y + 2, x + 2);
            corner_4 = flip_nodes(y + 2, x);
            mid_1 = flip_nodes(y, x + 1);
            mid_2 = flip_nodes(y + 1, x + 2);
            mid_3 = flip_nodes(y + 2, x + 1);
            mid_4 = flip_nodes(y + 1, x);

            if nargin == 3 || strcmp(schemes, 'corner first')

                element_nodes(e, :) = [corner_1 corner_2 corner_3 corner_4 mid_1 mid_2 mid_3 mid_4];

            else

                element_nodes(e, :) = [corner_1 mid_1 corner_2 mid_2 corner_3 mid_3 corner_4 mid_4];

            end

            e = e + 1;

        end

    end

    % 如果逆時針傳進來也沒關係
    % 他們會換回正確的位置
    if corner_coordinates(3, 1) > corner_coordinates(4, 1)
        tmp = corner_coordinates(3, :);
        corner_coordinates(3, :) = corner_coordinates(4, :);
        corner_coordinates(4, :) = tmp;
    end

    % edge 14 所有的節點位置
    edge_14_x = linspace(corner_coordinates(1, 1), corner_coordinates(3, 1), y_nodes);
    edge_14_y = linspace(corner_coordinates(1, 2), corner_coordinates(3, 2), y_nodes);

    % edge 23 所有的節點位置
    edge_23_x = linspace(corner_coordinates(2, 1), corner_coordinates(4, 1), y_nodes);
    edge_23_y = linspace(corner_coordinates(2, 2), corner_coordinates(4, 2), y_nodes);

    edge_line = 1 : x_nodes;
    center_line = (1 + x_nodes) : (x_mesh + 1 + x_nodes);

    for y_node = 1 : y_nodes

        if mod(y_node, 2) ~= 0

            x = linspace(edge_14_x(y_node), edge_23_x(y_node), x_nodes).';
            y = linspace(edge_14_y(y_node), edge_23_y(y_node), x_nodes).';

            node_coordinates(edge_line, :) = [x y];

            edge_line = edge_line + x_mesh + 1 + x_nodes;

        else

            x = linspace(edge_14_x(y_node), edge_23_x(y_node), x_mesh + 1).';
            y = linspace(edge_14_y(y_node), edge_23_y(y_node), x_mesh + 1).';

            node_coordinates(center_line, :) = [x y];

            center_line = center_line + x_mesh + 1 + x_nodes;

        end


    end

end
