function [] = drawingDeform(nodeCoordinates, elementNodes, displacements, magnificationFactor)
%
% drawing deform shape.
%
% @since 2.2.0
% @param {array} [nodeCoordinates] 節點位置.
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {type} [displacements] description.
% @param {array} [displacements] displacements.
% @param {number} [magnificationFactor] 放大係數.
% @see drawingMesh
%

    if nargin == 3
        magnificationFactor = max(max(nodeCoordinates) - min(nodeCoordinates)) / max(abs(displacements)) * 0.1;
    end

    displacementReshape = reshape(displacements, 2, []).' * magnificationFactor;

    figure;

    undeformedMesh = drawingMesh(nodeCoordinates, elementNodes, 'k-o');

    hold on;

    deformedMesh = drawingMesh(nodeCoordinates + displacementReshape, elementNodes, 'r--');

    legend([undeformedMesh, deformedMesh], 'undeformed', 'deformed', 'Location', 'northeast');

end
