function [number_elements, number_nodes, element_nodes, node_coordinates, nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh)
%
% for T4 auto mesh.
%
% @since 1.3.1
% @param {array} [corner_coordinates] corner coordinates �ѥ��ܥk �ѤU�ܤW.
% @param {number} [x_mesh] x ��V���X��.
% @param {number} [y_mesh] y ��V���X��.
% @return {number} [number_elements] number of elements.
% @return {number} [number_nodes] number of nodes.
% @return {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @return {array} [node_coordinates] �`�I��m.
% @return {array} [nodes] �s���Ϊ���m.
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

    % �����ƧǡA��K��X element_nodes
    % example:
    % 1 2 3
    % 4 5 6
    flip_nodes = reshape(1 : number_nodes, [x_nodes, y_nodes]).';

    % �ڭn�����Ƨ�
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

    % edge 14 �Ҧ����`�I��m
    edge_14_x = linspace(corner_coordinates(1, 1), corner_coordinates(3, 1), y_nodes);
    edge_14_y = linspace(corner_coordinates(1, 2), corner_coordinates(3, 2), y_nodes);

    % edge 23 �Ҧ����`�I��m
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
