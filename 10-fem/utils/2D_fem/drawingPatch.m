function [] = drawingPatch(nodeCoordinates, elementNodes, color)
%
% drawing stress
%
% @since 2.1.0
% @param {array} [nodeCoordinates] �`�I��m.
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {number|array} [color] �h��Ϊ��C��.
%

    figure;

    % number of elements
    number_elements = size(elementNodes, 1);

    for e = 1 : number_elements

        x = nodeCoordinates(elementNodes(e, :), 1);
        y = nodeCoordinates(elementNodes(e, :), 2);

        if length(color) ~= number_elements

            patch(x, y, color(elementNodes(e, :)));

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
