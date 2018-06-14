clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 3e7;
poisson = 0.3;
thickness = 1;

% preprocessing
number_elements = 2;
number_nodes = 9;
element_nodes = [1 7 3 4 5 2; 3 7 9 5 8 6];
node_coordinates = [0 0; 0 5; 0 10; 10 0; 10 5; 10 10; 20 0; 20 5; 20 10;];
% corner_coordinates = [0 0; 40 0; 0 2; 40 2;];
% x_mesh = 4;
% y_mesh = 1;
% [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q8(corner_coordinates, x_mesh, y_mesh)

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1 2 3 4 5 6].';
% prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

% force vector
force = zeros(G_dof, 1);
% force(2 * nodes(1, :)) = -0.75;
% force(2 * nodes(1, 1)) = -0.375;
% force(2 * nodes(1, end)) = -0.375;
% 這個不知道是為甚麼
force(17) = 5000 / 3;
force(13) = - (5000 / 3);

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% 確認是否畫對
% drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
output_displacements(displacements, number_nodes, G_dof);

% % figure;
% plot(node_coordinates(nodes(2, nodes(2, :) > 0), 1), displacements(2 * nodes(2, nodes(2, :) > 0)), 'bs');
% hold on;

% % output_reaction(displacements, stiffness, prescribed_dof, force)

% % [stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

% % drawing_stress(element_nodes, node_coordinates, stress_gp_cell, stress_node_cell);

% node_coordinates = [
%     0 0; 0.25 0; 0.5 0; 1.25 0; 2 0; 2.75 0; 3.5 0; 4 0; 4.5 0; 4.75 0; 5 0;
%     0 0.25; 1 0.25; 2 0.25; 3 0.25; 4 0.25; 5 0.25;
%     0 0.5; 0.75 0.5; 1.5 0.5; 1.75 0.5; 2 0.5; 2.25 0.5; 2.5 0.5; 3 0.5; 3.5 0.5; 4.25 0.5; 5 0.5;
% ];

% stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);
% displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

% plot(node_coordinates(nodes(2, nodes(2, :) > 0), 1), displacements(2 * nodes(2, nodes(2, :) > 0)), 'r^');
% hold on;

% x = 0 : 0.01 : 5;
% M = 600;
% b = 1;
% h = 0.5;
% I = 1 / 12 * b * h ^ 3;

% displacements = - M * x .^ 2 / (2 * E * I);

% plot(x, displacements, 'k-');

% legend('R-Q9', 'IR-Q9', 'R-Q8', 'IR-Q8', 'exact', 'Location', 'northeast');
