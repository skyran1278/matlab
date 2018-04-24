clc; clear; close all;

syms x A(x) b(x);

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2e7 2e7];
L = [1 1];

force = [20; 0; 0; 0; 0; 0; 0];

A0 = 1;
A(x) = A0 * (1 + x);
b(x) = 24 * A;

% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 7;

% generation of coordinates and connectivities
element_nodes = [1 2 3 4; 4 5 6 7];
node_coordinates = [0 1/3 2/3 1 4/3 5/3 2];

% boundary conditions and solution
% prescribed dofs
prescribed_dof = 7;

% settlement
displacements = [0; 0; 0; 0; 0; 0; 0];

[stiffness, force, displacements, stress] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, number_nodes, prescribed_dof, force);

% output element forces
output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements);

% exact
E = 2e7;
A = 1 + x;
L = 2;
b = 24 * A;
cond_stress = [0 20];
cond_u = [L 0];

[exact_node_coordinates, exact_displacements, exact_stress] = exact_solution(E, A, L, b, cond_stress, cond_u);

% plot
figure;
plot(exact_node_coordinates, exact_displacements, node_coordinates, displacements, 'ro:');

legend('exact solution', 'FEM', 'Location', 'northeast');
title('displacement');
xlabel('x (m)');
ylabel('displacement (m)');

% stress
figure;
plot(exact_node_coordinates, exact_stress);
hold on;
plot(stress(:, 1), stress(:, 2), 'ro:');

legend('exact solution', 'FEM', 'Location', 'northeast');
title('stress');
xlabel('x (m)');
ylabel('stress (N/m^2)');


