function stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness)
%
% compute stiffness matrix.
% for plane stress Q4 elements.
%
% @since 1.1.1
% @param {number} [gDof] global number of degrees of freedom.
% @param {number} [numberElements] number of elements.
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [nodeCoordinates] �`�I��m.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] �p��.
% @return {array} [stiffness] stiffness.
%

    stiffness = zeros(gDof);

    % �@�� element ���X�� nodes
    numNodePerElement = size(elementNodes, 2);

    shapeFunction = createShapeFunction(numNodePerElement);
    [gaussWeights, gaussLocations] = gauss2D(numNodePerElement);
    ngp = size(gaussWeights, 1);

    % �@�� element ���X�Ӧۥѫ�
    numEDof = 2 * numNodePerElement;
    elementDof = zeros(1, numEDof);

    for e = 1 : numberElements

        k = zeros(numEDof);

        for index = 1 : numNodePerElement

            % x
            elementDof(2 * index - 1) = 2 * elementNodes(e, index) - 1;

            % y
            elementDof(2 * index) = 2 * elementNodes(e, index);
        end

        % �o�̤w�g�b�������F
        for index = 1 : ngp

            xi = gaussLocations(index, 1);
            eta = gaussLocations(index, 2);

            % ��X���w�g�O�ƭȤF
            [~, naturalDerivatives] = shapeFunction(xi, eta);

            % number array
            [Jacob, ~, XYDerivatives] = Jacobian(nodeCoordinates(elementNodes(e, :), :), naturalDerivatives);

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

            k = k + det(Jacob) * gaussWeights(index) * (thickness * B.' * D * B);

            % FIXME: �o�̥|�ˤ��J�����D�A�y�����פ��@�ˡC
            stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + det(Jacob) * gaussWeights(index) * (thickness * B.' * D * B);

        end

        % k ���� 0
        % �]�� K �w�g�L�k exact �F
        % if det(k) ~= 0
        %     warning('det(k) <> 0: element %d, det(k) = %e\n', e, det(k));
        % end

        % stiffness matrix
        % stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + k;

    end

end
