clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 200e3;
poisson = 0.3;
thickness = 5;

% preprocessing
% number_elements: number of elements
number_elements = 24;

% number_nodes: number of nodes
number_nodes = 21;

% generation of coordinates and connectivities
% muti_element_nodes
element_nodes = [1 4 2; 2 4 5; 2 5 3; 3 5 6; 4 7 5; 5 7 8; 5 8 6; 6 8 9; 7 10 8; 8 10 11; 9 8 11; 9 11 12; 11 10 13; 11 13 14; 12 11 14; 12 14 15; 14 13 16; 14 16 17; 15 14 17; 15 17 18; 17 16 19; 17 19 20; 18 17 20; 18 20 21];
node_coordinates = [0 0; 0 10; 0 20; 10 0; 10 10; 10 20; 20 0; 20 10; 20 20; 30 0; 30 10; 30 20; 40 0; 40 10; 40 20; 50 0; 50 10; 50 20; 60 0; 60 10; 60 20];

drawing_mesh(node_coordinates, element_nodes, 'k-o');

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [37 38 39 40 41 42].';

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% force vector
force = zeros(G_dof, 1);
force(4) = -1000;

% deform ©ñ¤j«Y¼Æ
magnification_factor = 1e2;

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, number_nodes, node_coordinates, D, thickness);

% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

drawing_deform(node_coordinates, element_nodes, displacements);

% output displacements
output_displacements(displacements, number_nodes, G_dof);

output_reaction(displacements, stiffness, prescribed_dof, force)

output_stress(number_elements, element_nodes, node_coordinates, D, displacements)
