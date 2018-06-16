function meshPlot = drawingMesh(nodeCoordinates, elementNodes, format, schemes)
%
% mesh elementNodes
%
% @since 2.1.0
% @param {array} [nodeCoordinates] �`�I��m.
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {string} [format] plot format.
% @param {string} [schemes] cornerFirst or alongBoundary.
% @return {object} [meshPlot] plot �� object, �i�Ω� legend.
%

    numNodePerElement = size(elementNodes, 2);

    % close nodes around area
    % ����e�����I
    if (nargin == 3 || strcmp(schemes, 'cornerFirst')) && (numNodePerElement == 8 || numNodePerElement == 9)
        seg = [1 5 2 6 3 7 4 8 1];

    elseif (nargin == 3 || strcmp(schemes, 'cornerFirst')) && (numNodePerElement == 12 || numNodePerElement == 16)
        seg = [1 5 6 2 7 8 3 9 10 4 11 12 1];

    else
        seg = [1 : numNodePerElement, 1];
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
