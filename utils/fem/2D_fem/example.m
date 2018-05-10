clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 30e6;
poisson = 0.3;
thickness = 1;

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

% preprocessing
% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 4;

% generation of coordinates and connectivities
% muti_element_nodes
element_nodes = [1 3 2; 1 4 3];
node_coordinates = [0, 0; 0, 10; 20, 10; 20, 0];

drawing_mesh(node_coordinates, element_nodes, 'k-o');

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1 2 3 4]';

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% force vector
force = zeros(G_dof, 1);
force(5) = 5000;
force(7) = 5000;

% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, number_nodes, node_coordinates, D, thickness);

% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

% output displacements
output_displacements(displacements, number_nodes, G_dof);
