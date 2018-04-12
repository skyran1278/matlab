% 1D Simple Bar
% clear memory
clc; clear; close all;

% E: modulus of elasticity (N/m^2)
% A: area of cross section (cm^2)
% L: length of bar (cm)
E = [2.1e11 2.1e11];
A = 4e-4;
L = [2 2];

% numberElements: number of elements
numberElements = 2;

% numberNodes: number of nodes
numberNodes = 3;

% generation of coordinates and connectivities
elementNodes = [1 2; 2 3];
nodeCoordinates = [0 2 4];

% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
force = zeros(numberNodes, 1);
stiffness = zeros(numberNodes, numberNodes);
k = zeros(numberElements, 1);
displacements = zeros(numberNodes, 1);

% applied load at node 2
force(2) = -10000.0;

% settlement
displacements(3) = 25e-3;

% computation of the system stiffness matrix
for e = 1 : numberElements
    % elementDof: element degrees of freedom (Dof)
    elementDof = elementNodes(e, :);
    k(e) = E(e) * A / L(e);
    stiffness(elementDof, elementDof) = ...
        stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
end

% boundary conditions and solution
% prescribed dofs
prescribedDof = [1; 3];

% solution
GDof = numberNodes;
displacements = solution(GDof, prescribedDof, stiffness, force, displacements);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, ...
    numberNodes, prescribedDof, force);

% output element forces
output_element_forces(E, A, L, numberElements, elementNodes, displacements);
