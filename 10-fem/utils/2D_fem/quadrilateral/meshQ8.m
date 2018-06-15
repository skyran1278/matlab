function [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ8(cornerCoordinates, xMesh, yMesh, schemes)
%
% for Q8 auto mesh.
%
% @since 1.0.1
% @param {array} [cornerCoordinates] corner coordinates 由左至右 由下至上.
% @param {number} [xMesh] x 方向切幾份.
% @param {number} [yMesh] y 方向切幾份.
% @param {string} [schemes] cornerFirst or alongBoundary.
% @return {number} [numberElements] number of elements.
% @return {number} [numberNodes] number of nodes.
% @return {array} [elementNodes] 每個元素有幾個節點，還有他們的分佈.
% @return {array} [nodeCoordinates] 節點位置.
% @return {array} [nodes] 編號形狀位置，實際位置.
% @return {array} [flipNodes] 編號形狀位置，正的排序.
%

    xNodes = 2 * xMesh + 1;
    yNodes = 2 * yMesh + 1;

    numberElements = xMesh * yMesh;
    numberNodes = xNodes * yNodes - numberElements;

    elementNodes = zeros(numberElements, 8);
    nodeCoordinates = zeros(numberNodes, 2);

    % 正的排序，方便輸出 elementNodes
    % example:
    %  1     2     3     4     5     6     7
    %  8     0     9     0    10     0    11
    % 12    13    14    15    16    17    18
    flipNodes = zeros(yNodes, xNodes);

    edgeLine = 1 : xNodes;
    centerLine = (1 + xNodes) : (xMesh + 1 + xNodes);

    for yNode = 1 : yNodes

        if mod(yNode, 2) ~= 0

            flipNodes(yNode, :) = edgeLine;

            edgeLine = edgeLine + xMesh + 1 + xNodes;

        else

            flipNodes(yNode, 1 : 2 : xNodes) = centerLine;

            centerLine = centerLine + xMesh + 1 + xNodes;

        end

    end

    % 我要的的排序
    % example:
    % 12    13    14    15    16    17    18
    %  8     0     9     0    10     0    11
    %  1     2     3     4     5     6     7
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

            if nargin == 3 || strcmp(schemes, 'cornerFirst')

                elementNodes(e, :) = [corner1 corner2 corner3 corner4 mid1 mid2 mid3 mid4];

            else

                elementNodes(e, :) = [corner1 mid1 corner2 mid2 corner3 mid3 corner4 mid4];

            end

            e = e + 1;

        end

    end

    % 如果逆時針傳進來也沒關係
    % 他們會換回正確的位置
    if cornerCoordinates(3, 1) > cornerCoordinates(4, 1)
        tmp = cornerCoordinates(3, :);
        cornerCoordinates(3, :) = cornerCoordinates(4, :);
        cornerCoordinates(4, :) = tmp;
    end

    % edge 14 所有的節點位置
    edge14X = linspace(cornerCoordinates(1, 1), cornerCoordinates(3, 1), yNodes);
    edge14Y = linspace(cornerCoordinates(1, 2), cornerCoordinates(3, 2), yNodes);

    % edge 23 所有的節點位置
    edge23X = linspace(cornerCoordinates(2, 1), cornerCoordinates(4, 1), yNodes);
    edge23Y = linspace(cornerCoordinates(2, 2), cornerCoordinates(4, 2), yNodes);

    edgeLine = 1 : xNodes;
    centerLine = (1 + xNodes) : (xMesh + 1 + xNodes);

    for yNode = 1 : yNodes

        if mod(yNode, 2) ~= 0

            x = linspace(edge14X(yNode), edge23X(yNode), xNodes).';
            y = linspace(edge14Y(yNode), edge23Y(yNode), xNodes).';

            nodeCoordinates(edgeLine, :) = [x y];

            edgeLine = edgeLine + xMesh + 1 + xNodes;

        else

            x = linspace(edge14X(yNode), edge23X(yNode), xMesh + 1).';
            y = linspace(edge14Y(yNode), edge23Y(yNode), xMesh + 1).';

            nodeCoordinates(centerLine, :) = [x y];

            centerLine = centerLine + xMesh + 1 + xNodes;

        end


    end

end
