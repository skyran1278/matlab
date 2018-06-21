clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 3e7;
poisson = 0.3;
thickness = 1;

numberElements = 2;
numberNodes = 4;
elementNodes = [1 3 2; 1 4 3];
% m
nodeCoordinates = [0, 0; 0, 10; 20, 10; 20, 0];

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = (1 : 4).';

% force vector
% N
force = zeros(gDof, 1);
force(5) = 5000;
force(7) = 5000;


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

outputStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);

drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);

% save('lab.mat');
