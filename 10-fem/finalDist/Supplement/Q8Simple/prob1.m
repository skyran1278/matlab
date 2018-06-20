% clear memory
clear all; close all; clc;

%% initialize
% materials
E  = 3e7;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 23;
numberElements = 4;
nodeCoordinates=[(0:5:40)', zeros(9, 1); (0:10:40)', zeros(5, 1)+1; (0:5:40)', zeros(9, 1)+2];
elementNodes = [1 3 17 15 2 11 16 10; 3 5 19 17 4 12 18 11; 5 7 21 19 6 13 20 12; 7 9 23 21 8 14 22 13];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1 2; 19 20; 29 30];

% force vector 
force=zeros(GDof,1);
force([30 46]) = -0.25;
force(34:4:42) = -0.5;
force(32:4:44) = -1;

%% Q8
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);
