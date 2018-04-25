clc; clear; close all;

syms x A(x) b(x);

% E: modulus of elasticity (N/m^2)
% L: length of bar (m)
E = [2e7 2e7];
L = [1 1];

% external force
force = [20; 0; 0; 0; 0];

% A: area of cross section (m^2)
% A 可以是矩陣也可以是 x 的 function
% A = [4e-4 2e-4];
syms A(x);
A0 = 1;
A(x) = A0 * (1 + x);

% uniform_load
% no_uniform_load = b(x) = 0
b(x) = 24 * A;

% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 5;

% generation of coordinates and connectivities
% muti_element_nodes
element_nodes = [1 2 3; 3 4 5];
node_coordinates = [0 0.5 1 1.5 2];

% boundary conditions and solution
% prescribed dofs
prescribed_dof = 5;

% initial displacements
% initial_settlement
displacements = [0; 0; 0; 0; 0];

[stiffness, force, displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

% output displacements/reactions
output_displacements_reactions(displacements, stiffness, number_nodes, prescribed_dof, force);

% output element forces
output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements);

% output stress
[stress_coordinate, stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, displacements);

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
plot(exact_node_coordinates, exact_stress, stress_coordinate, stress, 'ro:');

legend('exact solution', 'FEM', 'Location', 'northeast');
title('stress');
xlabel('x (m)');
ylabel('stress (N/m^2)');


