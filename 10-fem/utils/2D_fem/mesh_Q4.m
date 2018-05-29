function [number_elements, number_nodes, element_nodes, node_coordinates, nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh)
%
% for T4 auto mesh.
%
% @since 1.3.1
% @param {array} [corner_coordinates] corner coordinates 由左至右 由下至上.
% @param {number} [x_mesh] x 方向切幾份.
% @param {number} [y_mesh] y 方向切幾份.
% @return {number} [number_elements] number of elements.
% @return {number} [number_nodes] number of nodes.
% @return {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @return {array} [node_coordinates] 節點位置.
% @return {array} [nodes] 編號形狀位置.
% @example
%
% corner_coordinates = [0 0; 20 0; 0 10; 20 10;];
% x_mesh = 2;
% y_mesh = 1;
% [number_elements, number_nodes, element_nodes, node_coordinates, nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh)
%
% =>
% number_elements =
%      2
% number_nodes =
%      6
% element_nodes =
%      1     2     5     4
%      2     3     6     5
% node_coordinates =
%      0     0
%     10     0
%     20     0
%      0    10
%     10    10
%     20    10
% nodes =
%      4     5     6
%      1     2     3
%
%


    x_nodes = x_mesh + 1;
    y_nodes = y_mesh + 1;

    number_elements = x_mesh * y_mesh;
    number_nodes = x_nodes * y_nodes;

    element_nodes = zeros(number_elements, 4);
    node_coordinates = zeros(number_nodes, 2);

    % 正的排序，方便輸出 element_nodes
    % example:
    % 1 2 3
    % 4 5 6
    flip_nodes = reshape(1 : number_nodes, [x_nodes, y_nodes]).';

    % 我要的的排序
    % example:
    % 4 5 6
    % 1 2 3
    nodes = flip(flip_nodes, 1);

    e = 1;

    for y = 1 : y_mesh

        for x = 1 : x_mesh

            node_1 = flip_nodes(y, x);
            node_2 = flip_nodes(y, x + 1);
            node_3 = flip_nodes(y + 1, x + 1);
            node_4 = flip_nodes(y + 1, x);

            element_nodes(e, :) = [node_1 node_2 node_3 node_4];

            e = e + 1;

        end

    end

    % edge 14 所有的節點位置
    edge_14_x = linspace(corner_coordinates(1, 1), corner_coordinates(3, 1), y_nodes);
    edge_14_y = linspace(corner_coordinates(1, 2), corner_coordinates(3, 2), y_nodes);

    % edge 23 所有的節點位置
    edge_23_x = linspace(corner_coordinates(2, 1), corner_coordinates(4, 1), y_nodes);
    edge_23_y = linspace(corner_coordinates(2, 2), corner_coordinates(4, 2), y_nodes);

    e = 1 : x_nodes;

    for index = 1 : y_nodes

        x = linspace(edge_14_x(index), edge_23_x(index), x_nodes).';
        y = linspace(edge_14_y(index), edge_23_y(index), x_nodes).';

        node_coordinates(e, :) = [x y];

        e = e + x_nodes;

    end

end
