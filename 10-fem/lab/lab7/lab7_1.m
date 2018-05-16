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
number_elements = 12;

% number_nodes: number of nodes
number_nodes = 21;

% generation of coordinates and connectivities
% muti_element_nodes
element_nodes = [1 2 9 8; 2 3 10 9; 3 4 11 10; 4 5 12 11; 5 6 13 12; 6 7 14 13; 8 9 16 15; 9 10 17 16; 10 11 18 17; 11 12 19 18; 12 13 20 19; 13 14 21 20];
node_coordinates = [0 -10; 10 -10; 20 -10; 30 -10; 40 -10; 50 -10; 60 -10; 0 0; 10 0; 20 0; 30 0; 40 0; 50 0; 60 0; 0 10; 10 10; 20 10; 30 10; 40 10; 50 10; 60 10];

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [13 14 27 28 41 42].';

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% force vector
force = zeros(G_dof, 1);
force(16) = -1000;

% ============================
% input above
% ============================

drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D_general(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
% output_displacements(displacements, number_nodes, G_dof);

% output_reaction(displacements, stiffness, prescribed_dof, force)

% output_stress(number_elements, element_nodes, node_coordinates, D, displacements)

displacement_reshape = reshape(displacements, 2, []).';

x = 0 : 0.1: 60;
P = force(16);
h = 20;
I = 1 / 12 * thickness * h ^ 3;
L = 60;


uy = P * x .^ 3 / (6 * E * I) - P * L ^ 2 * x / (2 * E * I) + P * L ^ 3 / (3 * E * I);

figure;
plot([0 10 20 30 40 50 60], displacement_reshape(8 : 14, 2), 'b-o', x, uy, 'r');
grid on;
xlabel('x(mm)');
ylabel('displacements(mm)');
title('neutral axis displacements(mm)');
legend({'FEM', 'exact'}, 'Location', 'southeast');

