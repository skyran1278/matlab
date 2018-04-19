% 1D Simple Bar
% clear memory
clc; clear; close all;

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2e7 2e7];
A = [1.5 2.5];
L = [1 1];
force = [20; 0; 0];

% numberElements: number of elements
numberElements = 2;

% numberNodes: number of nodes
numberNodes = 3;

% generation of coordinates and connectivities
elementNodes = [1 2; 2 3];
nodeCoordinates = [0 1 2];

% boundary conditions and solution
% prescribed dofs
prescribedDof = 3;

ngp = 3;

% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
% force = zeros(numberNodes, 1);
stiffness = zeros(numberNodes, numberNodes);
k = zeros(numberElements, 1);

% applied load at node 2
% force(2) = 30000.0;
syms x;

% computation of the system stiffness matrix
for e = 1 : numberElements
    % elementDof: element degrees of freedom (Dof)
    elementDof = elementNodes(e, :);

    % TODO: 這裡回家修
    J = L(e) / 2;
    inv_J = 1 / J;

    xe = linspace(-1, 1, ngp);

    Ne(x) = lagrange_interpolation(xe);

    B(x) = diff(Ne) * invJacobian;

    [shape,naturalDerivatives]=shapeFunctionL2(0.0);
    Be=naturalDerivatives*invJacobian;
    % k(e) = E(e) * A(e) / L(e);
    stiffness(elementDof, elementDof) = ...
        stiffness(elementDof, elementDof) + B(0)' * B(0) * 2 * detJacobian * E(e) * A(e);
    % force(elementDof)=force(elementDof)+...
        % 24*A(e)*shape'*detJacobian*w(ip);
end

% solution
GDof = numberNodes;
displacements = solution(GDof, prescribedDof, stiffness, force);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, ...
    numberNodes, prescribedDof, force);

% output element forces
output_element_forces(E, A, L, numberElements, elementNodes, displacements);
