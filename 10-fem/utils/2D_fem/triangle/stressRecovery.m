function [stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements)
%
% stress recovery.
%
% @since 1.0.3
% @param {number} [numberElements] number of elements.
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [nodeCoordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {array} [displacements] displacements.
% @return {cell} [stressGpCell] stress on gauss point.
% @return {cell} [stressNodeCell] stress on node.
%

    % 一個 element 有幾個 nodes
    numNodePerElement = size(elementNodes, 2);

    shapeFunction = createShapeFunction(numNodePerElement);
    [gaussWeights, gaussLocations] = gauss2D(numNodePerElement);
    ngp = size(gaussWeights, 1);

    % 一個 element 有幾個自由度
    numEDof = 2 * numNodePerElement;
    elementDof = zeros(1, numEDof);

    stressGpCell = cell(numberElements, 2);
    stressNodeCell = cell(numberElements, 1);

    % only for 2x2
    if numNodePerElement == 4
        recovery = [
            1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2;
            - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2;
            1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2;
            - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2;
        ];
    end

    for e = 1 : numberElements

        for index = 1 : numNodePerElement

            % x
            elementDof(2 * index - 1) = 2 * elementNodes(e, index) - 1;

            % y
            elementDof(2 * index) = 2 * elementNodes(e, index);
        end

        stressGp = zeros(ngp, 3);
        stressGpLocation = zeros(ngp, 2);

        for index = 1 : ngp

            xi2 = gaussLocations(index, 2);
            xi3 = gaussLocations(index, 3);

            [shape, naturalDerivatives] = shapeFunction(xi2, xi3);

            % number array
            [~, ~, XYDerivatives] = Jacobian(nodeCoordinates(elementNodes(e, :), :), naturalDerivatives);

            B = zeros(3, numEDof);

            % x 0 x 0 ...
            B(1, 1 : 2 : numEDof) = XYDerivatives(1, :);

            % 0 y 0 y ...
            B(2, 2 : 2 : numEDof) = XYDerivatives(2, :);

            % y x y x ...
            B(3, 1 : 2 : numEDof) = XYDerivatives(2, :);
            B(3, 2 : 2 : numEDof) = XYDerivatives(1, :);

            stressGp(index, :) = (D * B * displacements(elementDof, 1)).';
            stressGpLocation(index, :) = shape * nodeCoordinates(elementNodes(e, :), :);

        end

        % 目前 recovery 只支援 4 個節點的
        if numNodePerElement == 4
            stressNode = recovery * stressGp;
            stressNodeCell{e} = stressNode;
        end

        stressGpCell{e, 1} = stressGp;
        stressGpCell{e, 2} = stressGpLocation;

    end

end
