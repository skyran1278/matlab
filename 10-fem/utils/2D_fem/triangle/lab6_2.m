clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 200e3;
poisson = 0.3;
thickness = 5;

numberElements = 24;
numberNodes = 21;
elementNodes = [1 4 2; 2 4 5; 2 5 3; 3 5 6; 4 7 5; 5 7 8; 5 8 6; 6 8 9; 7 10 8; 8 10 11; 9 8 11; 9 11 12; 11 10 13; 11 13 14; 12 11 14; 12 14 15; 14 13 16; 14 16 17; 15 14 17; 15 17 18; 17 16 19; 17 19 20; 18 17 20; 18 20 21];
% m
nodeCoordinates = [0 -10; 0 0; 0 10; 10 -10; 10 0; 10 10; 20 -10; 20 0; 20 10; 30 -10; 30 0; 30 10; 40 -10; 40 0; 40 10; 50 -10; 50 0; 50 10; 60 -10; 60 0; 60 10];

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = (37 : 42).';

% force vector
% N
force = zeros(gDof, 1);
force(4) = -1000;


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

% outputStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);

drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);

% save('lab.mat');
