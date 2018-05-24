function [element_nodes, node_coordinates, number_elements, number_nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh)
%
% for T4
% auto output element_nodes node_coordinates.
%
% @since 1.0.0
% @param {array} [corner_coordinates] corner coordinates.
% @param {number} [x_mesh] x 方向切幾份.
% @param {number} [y_mesh] y 方向切幾份.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
%


    x_nodes = x_mesh + 1;
    y_nodes = y_mesh + 1;

    number_elements = x_mesh * y_mesh;
    number_nodes = x_nodes * y_nodes;

    element_nodes = zeros(number_elements, 4);
    node_coordinates = zeros(number_nodes, 2);

    nodes = reshape(1 : number_nodes, [x_nodes, y_nodes]).';

    e = 1;

    for y = 1 : y_mesh

        for x = 1 : x_mesh

            node_1 = nodes(y, x);
            node_2 = nodes(y, x + 1);
            node_3 = nodes(y + 1, x + 1);
            node_4 = nodes(y + 1, x);

            element_nodes(e, :) = [node_1 node_2 node_3 node_4];

            e = e + 1;

        end

    end

    edge_14_x = linspace(corner_coordinates(1, 1), corner_coordinates(4, 1), y_nodes);
    edge_14_y = linspace(corner_coordinates(1, 2), corner_coordinates(4, 2), y_nodes);
    edge_23_x = linspace(corner_coordinates(2, 1), corner_coordinates(3, 1), y_nodes);
    edge_23_y = linspace(corner_coordinates(2, 2), corner_coordinates(3, 2), y_nodes);

    e = 1 : x_nodes;

    for index = 1 : y_nodes

        x = linspace(edge_14_x(index), edge_23_x(index), x_nodes).';
        y = linspace(edge_14_y(index), edge_23_y(index), x_nodes).';

        node_coordinates(e, :) = [x y];

        e = e + x_nodes;

    end


end
