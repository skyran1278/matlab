function meshPlot = drawingMesh(nodeCoordinates, elementNodes, format, schemes)
%
% mesh elementNodes
%
% @since 2.1.0
% @param {array} [nodeCoordinates] 節點位置.
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {string} [format] plot format.
% @return {object} [meshPlot] plot 的 object, 可用於 legend.
%

    % close nodes around area
    if nargin == 3 || strcmp(schemes, 'cornerFirst')
        size(elementNodes, 2)

    else
        seg = [1 : size(elementNodes, 2), 1];
    end

    % number of elements
    numberElements = size(elementNodes, 1);

    for e = 1 : numberElements

        x = nodeCoordinates(elementNodes(e, seg), 1);
        y = nodeCoordinates(elementNodes(e, seg), 2);
        meshPlot = plot(x, y, format);

        hold on;

    end

    axis equal;
    hold off;

end
