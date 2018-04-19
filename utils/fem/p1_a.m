% 1D Simple Bar
% clear memory
clc; clear; close all;

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2.1e11 2.1e11 2.1e11 2.1e11];
A = [3e-4 3e-4 3e-4 3e-4];
L = [3 3 3 3];
force = [0 30000 0 0 0];

% numberElements: number of elements
numberElements = 4;

% numberNodes: number of nodes
numberNodes = 5;

% generation of coordinates and connectivities
elementNodes = [1 2; 2 3; 2 4; 2 5];
nodeCoordinates = [0 3 6 6 6];

% boundary conditions and solution
% prescribed dofs
prescribedDof = [1; 3; 4; 5];

% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
% force = zeros(numberNodes, 1);
stiffness = zeros(numberNodes, numberNodes);
k = zeros(numberElements, 1);

% applied load at node 2
% force(2) = 30000.0;

% computation of the system stiffness matrix
for e = 1 : numberElements
    % elementDof: element degrees of freedom (Dof)
    elementDof = elementNodes(e, :);
    k(e) = E(e) * A(e) / L(e);
    stiffness(elementDof, elementDof) = ...
        stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
end

% solution
GDof = numberNodes;
displacements = solution(GDof, prescribedDof, stiffness, force);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, ...
    numberNodes, prescribedDof, force);

% output element forces
output_element_forces(E, A, L, numberElements, elementNodes, displacements);
