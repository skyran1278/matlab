function [] = outputStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell)
%
% output stress.
% nodal
% average
%
% @since 2.0.0
% @param {array} [elementNodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {array} [nodeCoordinates] �`�I��m.
% @param {cell} [stressGpCell] stress on gauss point.
% @param {cell} [stressNodeCell] stress on node.
% @see drawingPatch
%

    numberElements = size(elementNodes, 1);
    numberNodes = size(nodeCoordinates, 1);

    accumulationStress = zeros(numberNodes, 3);
    centroidStress = zeros(numberElements, 3);

    accumulationCount = zeros(numberNodes, 1);

    % ��X np stress x
    fprintf('Stresses at Gauss points\n');
    fprintf('Element  gp             Sxx               Syy                Sxy\n');
    for e = 1 : length(stressGpCell)

        stress = stressGpCell{e};

        for index = 1 : size(stress, 1)

            fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
        end

    end

    % % ��X nodal stress x
    % fprintf('Element Nodal Stresses\n');
    % fprintf('Element  Node           Sxx               Syy                Sxy\n');
    % for e = 1 : numberElements

    %     stress = stressNodeCell{e, 1};

    %     for index = 1 : size(stress, 1)

    %         fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);

    %     end

    % end

    % % ��X nodal �����᪺ stress x
    % fprintf('Average Nodal Stresses\n');
    % fprintf('Node           Sxx               Syy                Sxy\n');
    % for e = 1 : numberElements

    %     stress = stressNodeCell{e};

    %     accumulationStress(elementNodes(e, :), :) = accumulationStress(elementNodes(e, :), :) + stress;
    %     accumulationCount(elementNodes(e, :)) = accumulationCount(elementNodes(e, :)) + 1;

    % end

    % averageStress = accumulationStress ./ accumulationCount;

    % % fprintf ���ݦC��ݦ�
    % fprintf('%4d%20.4e%20.4e%20.4e\n', [(1 : numberNodes); averageStress.']);




end
