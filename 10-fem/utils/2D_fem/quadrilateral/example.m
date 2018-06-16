clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 3e7;
poisson = 0.3;
thickness = 1;

% numberElements = 2;
% numberNodes = 6;
% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
% m
cornerCoordinates = [0 0; 40 0; 0 2; 40 2;];
xMesh = 4;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh)

nodesX = 2 * nodes - 1;
nodesY = 2 * nodes;
flipNodesX = 2 * flipNodes - 1;
flipNodesY = 2 * flipNodes;

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = reshape([flipNodesX(:, 1), flipNodesY(:, 1)].', [], 1);

% force vector
% N
force = zeros(gDof, 1);
force(nodesY(1, :)) = -20 * 2 / (length(nodesY(1, :)) - 1);
force(nodesY(1, 1)) = -20 * 2 / (length(nodesY(1, :)) - 1) / 2;
force(nodesY(1, end)) = -20 * 2 / (length(nodesY(1, :)) - 1) / 2;


displacements = zeros(gDof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

drawingMesh(nodeCoordinates, elementNodes, 'k-o');

D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

drawingDeform(nodeCoordinates, elementNodes, displacements);

outputDisplacements(displacements, numberNodes, gDof);

outputReaction(displacements, stiffness, prescribedDof, force);

[stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

outputStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell)

drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);

% save('lab.mat');
