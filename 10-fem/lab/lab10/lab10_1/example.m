clc; clear; close all;
tic;
syms x A(x) b(x);

% E: modulus of elasticity (N/m^2)
% L: length of bar (m)
E = [1e4 1e4];
L = [1 1];

% external force
% N
force = [0; 1;];

% A: area of cross section (m^2)
% A = [4e-4 2e-4];
A0 = 1;
A(x) = [A0 A0];

% uniform_load
% no_uniform_load = b(x) = 0
% N
b(x) = [x, x];

% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 3;

% generation of coordinates and connectivities
% muti_element_nodes
element_nodes = [1 2; 2 3];
node_coordinates = [0 1 2];

% boundary conditions and solution
% prescribed dofs
prescribed_dof = 1;

% initial displacements
% initial_settlement
displacements = [0; 0; 0;];

[stiffness, force, displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, number_nodes, prescribed_dof, force);

% output element forces
output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements);

% output stress
[stress_coordinate, stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, displacements);

% exact
E = 1e4;
A = 1;
L = 2;
b = x;
cond_stress = [0 1];
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
plot(exact_node_coordinates, exact_stress, stress_coordinate, stress, 'ro:');

legend('exact solution', 'FEM', 'Location', 'northeast');
title('stress');
xlabel('x (m)');
ylabel('stress (N/m^2)');
toc

