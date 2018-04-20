% 1D Simple Bar
% clear memory
clc; clear; close all;

syms x;

% E: modulus of elasticity (N/m^2)
% A: area of cross section (m^2)
% L: length of bar (m)
E = [2e7 2e7];
A = [1.5 2.5];
L = [1 1];

force = [20; 0; 0];

A0 = 1;
b(x) = 24 * A0 * (x + 1);

% number_elements: number of elements
number_elements = 2;

% number_nodes: number of nodes
number_nodes = 3;

% generation of coordinates and connectivities
element_nodes = [1 2; 2 3];
node_coordinates = [0 1 2];

% boundary conditions and solution
% prescribed dofs
prescribed_dof = 3;

fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof)
