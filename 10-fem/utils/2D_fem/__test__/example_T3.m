clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 200e3;
poisson = 0.3;
thickness = 5;

% preprocessing
% numberElements: number of elements
numberElements = 24;

% numberNodes: number of nodes
numberNodes = 21;

% generation of coordinates and connectivities
elementNodes = [1 4 2; 2 4 5; 2 5 3; 3 5 6; 4 7 5; 5 7 8; 5 8 6; 6 8 9; 7 10 8; 8 10 11; 9 8 11; 9 11 12; 11 10 13; 11 13 14; 12 11 14; 12 14 15; 14 13 16; 14 16 17; 15 14 17; 15 17 18; 17 16 19; 17 19 20; 18 17 20; 18 20 21];
nodeCoordinates = [0 0; 0 10; 0 20; 10 0; 10 10; 10 20; 20 0; 20 10; 20 20; 30 0; 30 10; 30 20; 40 0; 40 10; 40 20; 50 0; 50 10; 50 20; 60 0; 60 10; 60 20];

drawingMesh(nodeCoordinates, elementNodes, 'k-o');

% gDof: global number of degrees of freedom
gDof = 2 * numberNodes;

% boundary conditions and solution
% prescribed dofs
prescribedDof = [37 38 39 40 41 42].';

% initial displacements
displacements = zeros(gDof, 1);

% force vector
force = zeros(gDof, 1);
force(4) = -1000;

% deform ��j�Y��
magnificationFactor = 1e2;

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

% calculation of the system stiffness matrix
stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

% solution
displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

drawingDeform(nodeCoordinates, elementNodes, displacements, magnificationFactor);

% output displacements
outputDisplacements(displacements, numberNodes, gDof);

outputReaction(displacements, stiffness, prescribedDof, force)

outputStress(numberElements, elementNodes, nodeCoordinates, D, displacements)
