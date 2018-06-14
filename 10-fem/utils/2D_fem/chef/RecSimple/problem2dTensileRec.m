% A Thin Plate Subjected to Uniform Traction
% Rectangular Element Implementation
% 2 elements
% clear memory
clear all; 
clc;
close all;

% materials
E  = 30e6;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];
 
% trivial preprocessing
% numberElements: number of elements
numberElements = 2; 
% numberNodes: number of nodes
numberNodes = 6;
% coordinates and connectivities
elementNodes=[1 2 5 4; 2  3 6 5];
nodeCoordinates=[0, 0; 15, 0; 20 0; 0 10; 15 10; 20 10];
drawingMesh(nodeCoordinates,elementNodes,'Q4','k-o');

% GDof: global number of degrees of freedom
GDof = 2*numberNodes; 

% boundary conditions 
prescribedDof = [1 2 7]';
% force vector 
force = zeros(GDof,1);
force(5) = 5000; 
force(11) = 5000;

% calculation of the system stiffness matrix
stiffness = formStiffnessRec(GDof,numberElements,...
    elementNodes,nodeCoordinates,D,thickness);

% solution
displacements = solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);
M = max(max(nodeCoordinates)-min(nodeCoordinates))/max(abs(displacements))*0.1;
% reform displacement vector to fit nodeCoordinates
disp = vec2mat(displacements,2)*M;
hold on
drawingMesh(nodeCoordinates+disp,elementNodes,'Q4','r--');
