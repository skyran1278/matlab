function [] = drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell)
%
% drawing stress.
% average
% centroid
%
% @since 2.0.0
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [nodeCoordinates] �`�I��m.
% @param {cell} [stressGpCell] stress on gauss point.
% @param {cell} [stressNodeCell] stress on node.
% @see drawingPatch
%

    numberElements = size(elementNodes, 1);
    numberNodes = size(nodeCoordinates, 1);

    accumulationStress = zeros(numberNodes, 3);
    centroidStress = zeros(numberElements, 3);

    accumulationCount = zeros(numberNodes, 1);

    % �e���� stress x
    for e = 1 : numberElements

        stress = stressNodeCell{e};

        accumulationStress(elementNodes(e, :), :) = accumulationStress(elementNodes(e, :), :) + stress;
        accumulationCount(elementNodes(e, :)) = accumulationCount(elementNodes(e, :)) + 1;

    end

    averageStress = accumulationStress ./ accumulationCount;

    drawingPatch(nodeCoordinates, elementNodes, averageStress(:, 1));


    % �e centroid stress x
    for e = 1 : numberElements

        stress = stressGpCell{e};

        centroidStress(e, :) = mean(stress, 1);

    end

    drawingPatch(nodeCoordinates, elementNodes, centroidStress(:, 1));

end
