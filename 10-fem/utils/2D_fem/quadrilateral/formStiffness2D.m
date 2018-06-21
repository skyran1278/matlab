function stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness, reduced)
%
% compute stiffness matrix.
% for plane stress Q4 elements.
%
% @since 1.1.1
% @param {number} [gDof] global number of degrees of freedom.
% @param {number} [numberElements] number of elements.
% @param {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [nodeCoordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] 厚度.
% @return {array} [stiffness] stiffness.
%

    stiffness = zeros(gDof);

    % 一個 element 有幾個 nodes
    numNodePerElement = size(elementNodes, 2);

    shapeFunction = createShapeFunction(numNodePerElement);

    if nargin == 6
        [gaussWeights, gaussLocations] = gauss2D(numNodePerElement);
    else
        [gaussWeights, gaussLocations] = gauss2D(reduced);
    end

    ngp = size(gaussWeights, 1);

    % 一個 element 有幾個自由度
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

        % 這裡已經在做高斯了
        for index = 1 : ngp

            xi = gaussLocations(index, 1);
            eta = gaussLocations(index, 2);

            % 輸出的已經是數值了
            [~, naturalDerivatives] = shapeFunction(xi, eta);

            % number array
            [Jacob, ~, XYDerivatives] = Jacobian(nodeCoordinates(elementNodes(e, :), :), naturalDerivatives);

            % 應該要拆出來比較合理，不過算了。
            % 已經是數值了
            B = zeros(3, numEDof);

            % x 0 x 0 ...
            B(1, 1 : 2 : numEDof) = XYDerivatives(1, :);

            % 0 y 0 y ...
            B(2, 2 : 2 : numEDof) = XYDerivatives(2, :);

            % y x y x ...
            B(3, 1 : 2 : numEDof) = XYDerivatives(2, :);
            B(3, 2 : 2 : numEDof) = XYDerivatives(1, :);

            k = k + det(Jacob) * gaussWeights(index) * (thickness * B.' * D * B);

            % 這裡四捨五入的問題，造成答案不一樣。
            % IEEE 754 的問題
            % stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + det(Jacob) * gaussWeights(index) * (thickness * B.' * D * B);

        end

        % k 不為 0
        % 因為 K 已經無法 exact 了
        % if det(k) ~= 0
        %     warning('det(k) <> 0: element %d, det(k) = %e\n', e, det(k));
        % end

        % stiffness matrix
        stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + k;

    end

end
