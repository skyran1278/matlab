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

b = 24;

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

% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
% force = zeros(numberNodes, 1);
syms x;

number_element_nodes = length(elementNodes);

ngp = fix(number_element_nodes / 2) + 1;

Ne = lagrange_interpolation(linspace(-1, 1, number_element_nodes));
Be = zeros(1, number_element_nodes);
Ke = sym(zeros(number_element_nodes, number_element_nodes));
fe = sym(zeros(number_element_nodes, 1));
stiffness = zeros(numberNodes, numberNodes);


% computation of the system stiffness matrix
for e = 1 : numberElements

    % elementDof: element degrees of freedom (Dof)
    elementDof = elementNodes(e, :);

    xe = nodeCoordinates(elementDof).';

    J = diff(Ne) * xe;

    Be = 1 / J * diff(Ne);

    fe(x) = Ne.' * b(e);

    Ke(x) = Be.' * E(e) * A(e) * Be;

    stiffness(elementDof, elementDof) = stiffness(elementDof, elementDof) + J * gauss_quadrature(Ke, ngp);

    % TODO: 剩下 force 需要處理
    force(elementDof) = force(elementDof) + J * gauss_quadrature(fe, ngp);

end

% solution
GDof = numberNodes;
displacements = solution(GDof, prescribedDof, stiffness, force);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, ...
    numberNodes, prescribedDof, force);

% output element forces
output_element_forces(E, A, L, numberElements, elementNodes, displacements);
