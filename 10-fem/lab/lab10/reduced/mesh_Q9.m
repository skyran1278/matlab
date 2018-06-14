function [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q9(corner_coordinates, x_mesh, y_mesh, schemes)
%
% for Q9 auto mesh.
%
% @since 1.0.1
% @param {array} [corner_coordinates] corner coordinates �ѥ��ܥk �ѤU�ܤW.
% @param {number} [x_mesh] x ��V���X��.
% @param {number} [y_mesh] y ��V���X��.
% @param {string} [schemes] corner first or along boundary.
% @return {number} [number_elements] number of elements.
% @return {number} [number_nodes] number of nodes.
% @return {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @return {array} [node_coordinates] �`�I��m.
% @return {array} [nodes] �s���Ϊ���m�A��ڦ�m.
% @return {array} [flip_nodes] �s���Ϊ���m�A�����Ƨ�.
%

    x_nodes = 2 * x_mesh + 1;
    y_nodes = 2 * y_mesh + 1;

    number_elements = x_mesh * y_mesh;
    number_nodes = x_nodes * y_nodes;

    element_nodes = zeros(number_elements, 9);
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
            center_1 = flip_nodes(y + 1, x + 1);

            if nargin == 3 || strcmp(schemes, 'corner_first')

                element_nodes(e, :) = [corner_1 corner_2 corner_3 corner_4 mid_1 mid_2 mid_3 mid_4 center_1];

            else
                element_nodes(e, :) = [corner_1 mid_1 corner_2 mid_2 corner_3 mid_3 corner_4 mid_4 center_1];
            end

            e = e + 1;

        end

    end

    % �p�G�f�ɰw�Ƕi�Ӥ]�S���Y
    % �L�̷|���^���T����m
    if corner_coordinates(3, 1) > corner_coordinates(4, 1)
        tmp = corner_coordinates(3, :);
        corner_coordinates(3, :) = corner_coordinates(4, :);
        corner_coordinates(4, :) = tmp;
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
