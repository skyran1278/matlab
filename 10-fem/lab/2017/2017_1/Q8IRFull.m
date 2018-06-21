clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 200e9;
poisson = 0.3;
thickness = 1;

% numberElements = 2;
% numberNodes = 6;
% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
% m
cornerCoordinates = [0 0; 10 0; 0 2; 10 2;];
xMesh = 2;
yMesh = 1;
[numberElements, numberNodes, elementNodes, ~, nodes, flipNodes] = meshQ8(cornerCoordinates, xMesh, yMesh)
nodeCoordinates = [
    0 0; (3.75 / 2) 0; 3.75 0; (3.75 + 6.25 / 2) 0; 10 0;
    0 1; 5 1; 10 1;
    0 2; (6.25 / 2) 2; 6.25 2; (6.25 + 3.75 / 2) 2; 10 2;
];
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
force(nodesX(1, end)) = 15000;
force(nodesX(end, end)) = -15000;


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

fprintf('v = %.3e\n', displacements(nodesY(2, end)));

x = 10;
M = 30000;
I = 2 / 3;

exactDisplacements = -M / (2 * E * I) * x .^ 2;

fprintf('Rel. Error = %.4f%%\n', abs((displacements(nodesY(2, end)) - exactDisplacements) / exactDisplacements) * 100);

% save('lab.mat');
