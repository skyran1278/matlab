clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 30e6;
poisson = 0.3;
thickness = 1;

% preprocessing
% number_elements: number of elements
% number_elements = 2;

% number_nodes: number of nodes
% number_nodes = 6;

% generation of coordinates and connectivities
% muti_element_nodes

% element_nodes = [1 2 5 4; 2 3 6 5];
% node_coordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
corner_coordinates = [0 0; 2 0.5; 0 1; 2 1;];
x_mesh = 1;
y_mesh = 1;
[number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
% prescribed_dof = [1 2 7].';
prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

% force vector
force = zeros(G_dof, 1);
% force(5) = 5000;
% force(11) = 5000;
% force(2 * nodes(:, end) - 1) = 5000;

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% 確認是否畫對
drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
output_displacements(displacements, number_nodes, G_dof);

% output_reaction(displacements, stiffness, prescribed_dof, force)

[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

