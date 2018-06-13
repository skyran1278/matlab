% clear memory
clear all; close all; clc;

%% initialize Q8
clear;
% materials
E  = 3e7;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 23;
numberElements = 4;
nodeCoordinates = [0,0;5,0;10,0;15,0;20,0;25,0;30,0;35,0;40,0;
                   0,1;10,1;20,1;30,1;40,1;
                   0,2;5,2;10,2;15,2;20,2;25,2;30,2;35,2;40,2];
elementNodes = [1,2,3,11,17,16,15,10;
                3,4,5,12,19,18,17,11;
                5,6,7,13,21,20,19,12;
                7,8,9,14,23,22,21,13];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1,2,19,20,29,30];

% force vector 
force=zeros(GDof,1);
force(30) = -0.25;
force(32) = -1;
force(34) = -0.5;
force(36) = -1;
force(38) = -0.5;
force(40) = -1;
force(42) = -0.5;
force(44) = -1;
force(46) = -0.25;
%% Q8
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness,'Q8','3x3');

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
%outputDisplacements(displacements, numberNodes, GDof);
display('* Q8')
display('x-coor   y-coor         Ux           Uy')
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(9,1),nodeCoordinates(9,2),displacements(17),displacements(18))
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(14,1),nodeCoordinates(14,2),displacements(27),displacements(28))
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(23,1),nodeCoordinates(23,2),displacements(45),displacements(46))
%% initialize Q8R
clear;
% materials
E  = 3e7;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 23;
numberElements = 4;
nodeCoordinates = [0,0;5,0;10,0;15,0;20,0;25,0;30,0;35,0;40,0;
                   0,1;10,1;20,1;30,1;40,1;
                   0,2;5,2;10,2;15,2;20,2;25,2;30,2;35,2;40,2];
elementNodes = [1,2,3,11,17,16,15,10;
                3,4,5,12,19,18,17,11;
                5,6,7,13,21,20,19,12;
                7,8,9,14,23,22,21,13];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1,2,19,20,29,30];

% force vector 
force=zeros(GDof,1);
force(30) = -0.25;
force(32) = -1;
force(34) = -0.5;
force(36) = -1;
force(38) = -0.5;
force(40) = -1;
force(42) = -0.5;
force(44) = -1;
force(46) = -0.25;
%% Q8R
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness,'Q8','2x2');

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
%outputDisplacements(displacements, numberNodes, GDof);
display('* Q8R')
display('x-coor   y-coor         Ux           Uy')
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(9,1),nodeCoordinates(9,2),displacements(17),displacements(18))
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(14,1),nodeCoordinates(14,2),displacements(27),displacements(28))
fprintf('  %d       %d      %11.3e  %11.3e\n',nodeCoordinates(23,1),nodeCoordinates(23,2),displacements(45),displacements(46))




