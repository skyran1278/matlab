% 1D Simple Bar
% clear memory
clc; clear; close all;

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2e11 6.67e10 6.67e10];
A = 12.5e-4;
L = [1.25 0.75 0.75];

% numberElements: number of elements
numberElements = 3;

% numberNodes: number of nodes
numberNodes = 4;

% generation of coordinates and connectivities
elementNodes = [1 2; 2 3; 2 4];
nodeCoordinates = [0 1.25 2.00 2.00];

% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
force = zeros(numberNodes, 1);
stiffness = zeros(numberNodes, numberNodes);
k = zeros(numberElements, 1);

% applied load at node 2
force(2) = 40000.0;

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
prescribedDof = [1; 3; 4];

% solution
GDof = numberNodes;
displacements = solution(GDof, prescribedDof, stiffness, force);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, ...
    numberNodes, prescribedDof, force);

% output element forces
output_element_forces(E, A, L, numberElements, elementNodes, displacements);
