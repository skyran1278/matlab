clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 30e3;
poisson = 0.3;
thickness = 1;

% numberElements = 2;
% numberNodes = 6;
% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
% m
cornerCoordinates = [0 0; 5 0; 0 0.5; 5 0.5;];
xMesh = 5;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ9(cornerCoordinates, xMesh, yMesh)

nodesX = 2 * nodes - 1;
nodesY = 2 * nodes;
flipNodesX = 2 * flipNodes - 1;
flipNodesY = 2 * flipNodes;

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = reshape([flipNodesX(:, 1), flipNodesY(2, 1)].', [], 1);

% force vector
% N
force = zeros(gDof, 1);
force(nodesX(1, end)) = 1200;
force(nodesX(end, end)) = -1200;


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


figure;
plot(node_coordinates(flip_nodes(2, :), 1), displacements(2 * flip_nodes(2, :)), 'bo');
hold on;

x = 0 : 0.01 : 5;
M = 600;
b = 1;
h = 0.5;
I = 1 / 12 * b * h ^ 3;

displacements = - M * x .^ 2 / (2 * E * I);

plot(x, displacements, 'k-');
% save('lab.mat');
