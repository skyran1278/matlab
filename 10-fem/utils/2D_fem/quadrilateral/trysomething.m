clc; clear; close all;

% vars = load('lab7.mat');

% stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

% displacements = solution(vars.gDof, vars.prescribedDof, stiffness, vars.force, vars.displacements);

% outputDisplacements(displacements, vars.numberNodes, vars.gDof);

% [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, displacements);

% outputStress(vars.elementNodes, vars.nodeCoordinates, stressGpCell, stressNodeCell);

% a = 0.1;
% b = 0.2;
% if a + b == 0.3
%     fprintf('a + b = 0.3');
% else
%     c = a + b
% end

cornerCoordinates = [0 0; 5 0; 0 0.5; 5 0.5;];
xMesh = 5;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ9(cornerCoordinates, xMesh, yMesh)
