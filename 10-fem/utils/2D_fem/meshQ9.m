function [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ9(cornerCoordinates, xMesh, yMesh, schemes)
%
% for Q9 auto mesh.
%
% @since 1.0.1
% @param {array} [cornerCoordinates] corner coordinates �ѥ��ܥk �ѤU�ܤW.
% @param {number} [xMesh] x ��V���X��.
% @param {number} [yMesh] y ��V���X��.
% @param {string} [schemes] corner first or along boundary.
% @return {number} [numberElements] number of elements.
% @return {number} [numberNodes] number of nodes.
% @return {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @return {array} [nodeCoordinates] �`�I��m.
% @return {array} [nodes] �s���Ϊ���m�A��ڦ�m.
% @return {array} [flipNodes] �s���Ϊ���m�A�����Ƨ�.
%

    xNodes = 2 * xMesh + 1;
    yNodes = 2 * yMesh + 1;

    numberElements = xMesh * yMesh;
    numberNodes = xNodes * yNodes;

    elementNodes = zeros(numberElements, 9);
    nodeCoordinates = zeros(numberNodes, 2);

    % �����ƧǡA��K��X elementNodes
    % example:
    % 1 2 3
    % 4 5 6
    flipNodes = reshape(1 : numberNodes, [xNodes, yNodes]).';

    % �ڭn�����Ƨ�
    % example:
    % 4 5 6
    % 1 2 3
    nodes = flip(flipNodes, 1);

    e = 1;

    for y = 1 : 2 : yNodes - 2

        for x = 1 : 2 : xNodes - 2

            corner1 = flipNodes(y, x);
            corner2 = flipNodes(y, x + 2);
            corner3 = flipNodes(y + 2, x + 2);
            corner4 = flipNodes(y + 2, x);
            mid1 = flipNodes(y, x + 1);
            mid2 = flipNodes(y + 1, x + 2);
            mid3 = flipNodes(y + 2, x + 1);
            mid4 = flipNodes(y + 1, x);
            center1 = flipNodes(y + 1, x + 1);

            if nargin == 3 || strcmp(schemes, 'cornerFirst')

                elementNodes(e, :) = [corner1 corner2 corner3 corner4 mid1 mid2 mid3 mid4 center1];

            else
                elementNodes(e, :) = [corner1 mid1 corner2 mid2 corner3 mid3 corner4 mid4 center1];
            end

            e = e + 1;

        end

    end

    % �p�G�f�ɰw�Ƕi�Ӥ]�S���Y
    % �L�̷|���^���T����m
    if cornerCoordinates(3, 1) > cornerCoordinates(4, 1)
        tmp = cornerCoordinates(3, :);
        cornerCoordinates(3, :) = cornerCoordinates(4, :);
        cornerCoordinates(4, :) = tmp;
    end

    % edge 14 �Ҧ����`�I��m
    edge14X = linspace(cornerCoordinates(1, 1), cornerCoordinates(3, 1), yNodes);
    edge14Y = linspace(cornerCoordinates(1, 2), cornerCoordinates(3, 2), yNodes);

    % edge 23 �Ҧ����`�I��m
    edge23X = linspace(cornerCoordinates(2, 1), cornerCoordinates(4, 1), yNodes);
    edge23Y = linspace(cornerCoordinates(2, 2), cornerCoordinates(4, 2), yNodes);

    e = 1 : xNodes;

    for index = 1 : yNodes

        x = linspace(edge14X(index), edge23X(index), xNodes).';
        y = linspace(edge14Y(index), edge23Y(index), xNodes).';

        nodeCoordinates(e, :) = [x y];

        e = e + xNodes;

    end

end
