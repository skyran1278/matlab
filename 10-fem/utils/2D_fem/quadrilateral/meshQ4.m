function [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh)
%
% for Q4 auto mesh.
%
% @since 1.3.2
% @param {array} [cornerCoordinates] corner coordinates �ѥ��ܥk �ѤU�ܤW.
% @param {number} [xMesh] x ��V���X��.
% @param {number} [yMesh] y ��V���X��.
% @return {number} [numberElements] number of elements.
% @return {number} [numberNodes] number of nodes.
% @return {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @return {array} [nodeCoordinates] �`�I��m.
% @return {array} [nodes] �s���Ϊ���m�A��ڦ�m.
% @return {array} [flipNodes] �s���Ϊ���m�A�����Ƨ�.
% @example
%
% cornerCoordinates = [0 0; 20 0; 0 10; 20 10;];
% xMesh = 2;
% yMesh = 1;
% schemes = 'Q4';
% [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = mesh(cornerCoordinates, xMesh, yMesh, schemes)
%
% =>
% numberElements =
%      2
% numberNodes =
%      6
% elementNodes =
%      1     2     5     4
%      2     3     6     5
% nodeCoordinates =
%      0     0
%     10     0
%     20     0
%      0    10
%     10    10
%     20    10
% nodes =
%      4     5     6
%      1     2     3
% flipNodes =
%      1     2     3
%      4     5     6
%
%


    xNodes = xMesh + 1;
    yNodes = yMesh + 1;

    numberElements = xMesh * yMesh;
    numberNodes = xNodes * yNodes;

    elementNodes = zeros(numberElements, 4);
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

    for y = 1 : yMesh

        for x = 1 : xMesh

            node1 = flipNodes(y, x);
            node2 = flipNodes(y, x + 1);
            node3 = flipNodes(y + 1, x + 1);
            node4 = flipNodes(y + 1, x);

            elementNodes(e, :) = [node1 node2 node3 node4];

            e = e + 1;

        end

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
