function [] = drawing_patch(node_coordinates, element_nodes, color)
%
% Since it is rather easier to make unintentional mistakes while typin  the coordinates and connectivities in 2D, it would be better to draw the mesh so you can visualize it. We have written an extensibl  function drawingMesh.m that is useful to visualize your mesh in MATLAB.
%
% @since 1.1.0
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {number|array} [color] �h��Ϊ��C��.
%

    figure;

    % number of elements
    number_elements = size(element_nodes, 1);

    for e = 1 : number_elements

        x = node_coordinates(element_nodes(e, :), 1);
        y = node_coordinates(element_nodes(e, :), 2);

        if length(color) ~= number_elements

            patch(x, y, color(element_nodes(e, :)));

        else
            patch(x, y, color(e));
        end

        hold on;

    end

    axis equal
    colormap jet;
    colorbar;
    hold off;

end
