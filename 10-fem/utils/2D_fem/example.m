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
cornerCoordinates = [0 0; 40 0; 0 2; 40 2;];
xMesh = 4;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ8(cornerCoordinates, xMesh, yMesh)

% gDof: global number of degrees of freedom
gDof = 2 * numberNodes;

% boundary conditions and solution
% prescribed dof
% prescribedDof = [2 * nodes(end, 1) - 1, 2 * nodes(2, 1) - 1, 2 * nodes(2, 1), 2 * nodes(1, 1) - 1].';
prescribedDof = reshape([2 * flipNodes(:, 1) - 1, 2 * flipNodes(:, 1)].', [], 1);

% force vector
force = zeros(gDof, 1);
% force(2 * nodes(1, :)) = -0.75;
% force(2 * nodes(1, 1)) = -0.375;
% force(2 * nodes(1, end)) = -0.375;


% initial displacements
displacements = zeros(gDof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

drawingMesh(nodeCoordinates, elementNodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

% calculation of the system stiffness matrix
stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

% solution
displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

drawingDeform(nodeCoordinates, elementNodes, displacements);

% output displacements
outputDisplacements(displacements, numberNodes, gDof);


outputReaction(displacements, stiffness, prescribedDof, force)

[stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);
