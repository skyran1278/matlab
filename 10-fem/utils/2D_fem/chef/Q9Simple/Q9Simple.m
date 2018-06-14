% clear memory
clear all; close all; clc;

%% initialize
% materials
E  = 3e10;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 21;
numberElements = 3;
nodeCoordinates = [0,0;5,0;10,0;15,0;20,0;25,0;30,0;
                   0,5;5,5;10,5;15,5;20,5;25,5;30,5;
                   0,10;5,10;10,10;15,10;20,10;25,10;30,10];
elementNodes = [1,3,17,15,2,10,16,8,9;3,5,19,17,4,12,18,10,11;5,7,21,19,6,14,20,12,13];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1,2,15,16,29,30];

% force vector 
force=zeros(GDof,1);
force(end) = -10000;

%% Q9
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);
