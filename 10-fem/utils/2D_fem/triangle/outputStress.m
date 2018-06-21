function [] = outputStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell)
%
% output stress.
% nodal
% average
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

    % 輸出 np stress x
    fprintf('Stresses at Gauss points\n');
    fprintf('Element  gp             Sxx               Syy                Sxy\n');
    for e = 1 : length(stressGpCell)

        stress = stressGpCell{e};

        for index = 1 : size(stress, 1)

            fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
        end

    end

    % % 輸出 nodal stress x
    % fprintf('Element Nodal Stresses\n');
    % fprintf('Element  Node           Sxx               Syy                Sxy\n');
    % for e = 1 : numberElements

    %     stress = stressNodeCell{e, 1};

    %     for index = 1 : size(stress, 1)

    %         fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);

    %     end

    % end

    % % 輸出 nodal 平均後的 stress x
    % fprintf('Average Nodal Stresses\n');
    % fprintf('Node           Sxx               Syy                Sxy\n');
    % for e = 1 : numberElements

    %     stress = stressNodeCell{e};

    %     accumulationStress(elementNodes(e, :), :) = accumulationStress(elementNodes(e, :), :) + stress;
    %     accumulationCount(elementNodes(e, :)) = accumulationCount(elementNodes(e, :)) + 1;

    % end

    % averageStress = accumulationStress ./ accumulationCount;

    % % fprintf 先看列後看行
    % fprintf('%4d%20.4e%20.4e%20.4e\n', [(1 : numberNodes); averageStress.']);




end
