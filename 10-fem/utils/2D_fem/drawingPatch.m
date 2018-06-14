function [] = drawingPatch(nodeCoordinates, elementNodes, color)
%
% drawing stress
%
% @since 2.1.0
% @param {array} [nodeCoordinates] 節點位置.
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {number|array} [color] 多邊形的顏色.
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
