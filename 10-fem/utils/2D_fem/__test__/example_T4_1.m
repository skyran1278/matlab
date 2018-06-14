clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 30e6;
poisson = 0.3;
thickness = 1;

% preprocessing
% numberElements: number of elements
% numberElements = 2;

% numberNodes: number of nodes
% numberNodes = 6;

% generation of coordinates and connectivities

% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
cornerCoordinates = [0 0; 2 0.5; 0 1; 2 1;];
xMesh = 1;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

% gDof: global number of degrees of freedom
gDof = 2 * numberNodes;

% boundary conditions and solution
% prescribed dofs
% prescribedDof = [1 2 7].';
prescribedDof = reshape([2 * flipNodes(:, 1) - 1, 2 * flipNodes(:, 1)].', [], 1);

% force vector
force = zeros(gDof, 1);
% force(5) = 5000;
% force(11) = 5000;
% force(2 * nodes(:, end) - 1) = 5000;

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

% outputReaction(displacements, stiffness, prescribedDof, force)

[stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

