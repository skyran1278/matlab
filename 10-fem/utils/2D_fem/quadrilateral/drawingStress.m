function [] = drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell)
%
% drawing stress.
% average
% centroid
%
% @since 2.0.0
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [nodeCoordinates] 節點位置.
% @param {cell} [stressGpCell] stress on gauss point.
% @param {cell} [stressNodeCell] stress on node.
% @see drawingPatch
%

    numberElements = size(elementNodes, 1);
    numberNodes = size(nodeCoordinates, 1);

    accumulationStress = zeros(numberNodes, 3);
    centroidStress = zeros(numberElements, 3);

    accumulationCount = zeros(numberNodes, 1);

    % 畫平均 stress x
    for e = 1 : numberElements

        stress = stressNodeCell{e};

        accumulationStress(elementNodes(e, :), :) = accumulationStress(elementNodes(e, :), :) + stress;
        accumulationCount(elementNodes(e, :)) = accumulationCount(elementNodes(e, :)) + 1;

    end

    averageStress = accumulationStress ./ accumulationCount;

    drawingPatch(nodeCoordinates, elementNodes, averageStress(:, 1));
    % fprintf 先看列
    fprintf('%4d%20.4e%20.4e%20.4e\n', [(1 : numberNodes); averageStress.']);


    % 畫 centroid stress x
    for e = 1 : numberElements

        stress = stressGpCell{e, 1};

        centroidStress(e, :) = mean(stress, 1);

    end

    drawingPatch(nodeCoordinates, elementNodes, centroidStress(:, 1));

end
