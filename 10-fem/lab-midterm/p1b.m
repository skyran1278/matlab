clc; clear; close all;

syms x A(x) b(x);

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2.1e11 2.1e11];
L = [2 2];

force = [0; -10000; 0];

A0 = 4e-4;
A(x) = A0;
b(x) = 1;

% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 3;

% generation of coordinates and connectivities
element_nodes = [1 2; 2 3];
node_coordinates = [0 2 4];

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1; 3];

% settlement
displacements = [0; 0; 25e-3];

[stiffness, force, displacements, stress] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

% exact
% E = 2e7;
% A = 1 + x;
% L = 2;
% b = 24 * A;
% cond_stress = [0 20];
% cond_u = [L 0];

% [exact_node_coordinates, exact_displacements, exact_stress] = exact_solution(E, A, L, b, cond_stress, cond_u);

% plot
% figure;
% plot(exact_node_coordinates, exact_displacements, node_coordinates, displacements, 'ro:');

% legend('exact solution', 'FEM', 'Location', 'northeast');
% title('displacement');
% xlabel('x (m)');
% ylabel('displacement (m)');

% % stress
% figure;
% plot(exact_node_coordinates, exact_stress);
% hold on;
% stairs(node_coordinates, stress, 'ro:');

% legend('exact solution', 'FEM', 'Location', 'northeast');
% title('stress');
% xlabel('x (m)');
% ylabel('stress (N/m^2)');

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, number_nodes, prescribed_dof, force);

% output element forces
output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements);
