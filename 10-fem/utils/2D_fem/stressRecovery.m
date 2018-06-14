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
    [weight, location] = gauss_2D(numNodePerElement);
    ngp = size(weight, 1);

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

        stress_gp = zeros(ngp, 3);
        stress_gp_location = zeros(ngp, 2);

        % �o�̤w�g�b�������F
        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            % ��X���w�g�O�ƭȤF
            [shape, naturalDerivatives] = shapeFunction(xi, eta);

            % number array
            [~, ~, XYDerivatives] = form_jacobian(nodeCoordinates(elementNodes(e, :), :), naturalDerivatives);

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

            stress_gp(index, :) = (D * B * displacements(elementDof, 1)).';
            stress_gp_location(index, :) = shape * nodeCoordinates(elementNodes(e, :), :);

        end

        % stress_node = recovery * stress_gp;

        stressGpCell{e, 1} = stress_gp;
        stressGpCell{e, 2} = stress_gp_location;
        % stressNodeCell{e} = stress_node;

    end

end
