function [stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements)
%
% stress recovery.
%
% @since 1.0.3
% @param {number} [numberElements] number of elements.
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [nodeCoordinates] �`�I��m.
% @param {array} [D] 2D matrix D.
% @param {array} [displacements] displacements.
% @return {cell} [stressGpCell] stress on gauss point.
% @return {cell} [stressNodeCell] stress on node.
%

    % �@�� element ���X�� nodes
    numNodePerElement = size(elementNodes, 2);

    shapeFunction = createShapeFunction(numNodePerElement);
    [gaussWeights, ~] = gauss2D(numNodePerElement);
    ngp = size(gaussWeights, 1);

    % �@�� element ���X�Ӧۥѫ�
    numEDof = 2 * numNodePerElement;
    elementDof = zeros(1, numEDof);

    stressGpCell = cell(numberElements, 2);
    stressNodeCell = cell(numberElements, 1);

    % recovery = [
    %     1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2;
    %     - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2, 1 - sqrt(3) / 2;
    %     1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2, - 1 / 2;
    %     - 1 / 2, 1 - sqrt(3) / 2, - 1 / 2, 1 + sqrt(3) / 2;
    % ];

    for e = 1 : numberElements

        for index = 1 : numNodePerElement

            % x
            elementDof(2 * index - 1) = 2 * elementNodes(e, index) - 1;

            % y
            elementDof(2 * index) = 2 * elementNodes(e, index);
        end

        stressGp = zeros(ngp, 3);
        stressGpLocation = zeros(ngp, 2);

        % �o�̤w�g�b�������F
        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            % ��X���w�g�O�ƭȤF
            [shape, naturalDerivatives] = shapeFunction(xi, eta);

            % number array
            [~, ~, XYDerivatives] = Jacobian(nodeCoordinates(elementNodes(e, :), :), naturalDerivatives);

            % ���ӭn��X�Ӥ���X�z�A���L��F�C
            % �w�g�O�ƭȤF
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

        % stressNode = recovery * stressGp;

        stressGpCell{e, 1} = stressGp;
        stressGpCell{e, 2} = stressGpLocation;
        % stressNodeCell{e} = stressNode;

    end

end
