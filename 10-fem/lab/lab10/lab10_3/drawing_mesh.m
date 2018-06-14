function mesh_plot = drawing_mesh(node_coordinates, element_nodes, format)
%
% Since it is rather easier to make unintentional mistakes while typin  the coordinates and connectivities in 2D, it would be better to draw the mesh so you can visualize it. We have written an extensibl  function drawingMesh.m that is useful to visualize your mesh in MATLAB.
%
% @since 1.1.0
% @param {array} [node_coordinates] 節點位置.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {string} [format] plot format.
% @return {object} [mesh_plot] plot 的 object, 可用於 legend.
%

    % close nodes around area
    seg_1 = [1, 4, 2, 5, 3, 6, 1];

    % number of elements
    number_elements = size(element_nodes, 1);

    for e = 1 : number_elements

        x = node_coordinates(element_nodes(e, seg_1), 1);
        y = node_coordinates(element_nodes(e, seg_1), 2);
        mesh_plot = plot(x, y, format);

        hold on;

    end

    axis equal;
    hold off;

end
