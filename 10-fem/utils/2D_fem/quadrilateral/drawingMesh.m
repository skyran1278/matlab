function meshPlot = drawingMesh(nodeCoordinates, elementNodes, format, schemes)
%
% mesh elementNodes
%
% @since 2.1.0
% @param {array} [nodeCoordinates] �`�I��m.
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {string} [format] plot format.
% @return {object} [meshPlot] plot �� object, �i�Ω� legend.
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
