clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 3e7;
poisson = 0.3;
thickness = 1;

numberElements = 8;
numberNodes = 25;
elementNodes = [
    1 11 3 6 7 2;
    3 11 13 7 12 8;
    11 21 13 16 17 12;
    13 21 23 17 22 18;
    3 13 5 8 9 4;
    5 13 15 9 14 10;
    13 23 15 18 19 14;
    15 23 25 19 24 20;
];
% m
nodeCoordinates = [
    0 0; 0 2.5; 0 5; 0 7.5; 0 10;
    5 0; 5 2.5; 5 5; 5 7.5; 5 10;
    10 0; 10 2.5; 10 5; 10 7.5; 10 10;
    15 0; 15 2.5; 15 5; 15 7.5; 15 10;
    20 0; 20 2.5; 20 5; 20 7.5; 20 10;
];

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = (1 : 10).';

% force vector
% N
force = zeros(gDof, 1);
force(49) = 5000 / 6;
force(47) = 5000 / 3;
force(43) = -5000 / 3;
force(41) = -5000 / 6;


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

% save('lab10.mat');
