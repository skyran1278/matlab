% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
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
numberElements = 8; 
% numberNodes: number of nodes
numberNodes = 25;
% coordinates and connectivities
elementNodes=[1 11 3 6 7 2;3 11 13 7 12 8;
              11 21 13 16 17 12; 13 21 23 17 22 18;
              3 13 5 8 9 4; 5 13 15 9 14 10;
              13 23 15 18 19 14; 15 23 25 19 24 20];
nodeCoordinates=[0, 0; 0, 2.5; 0, 5; 0, 7.5; 0, 10;
                 5, 0; 5, 2.5; 5, 5; 5, 7.5; 5, 10;
                 10, 0; 10, 2.5; 10, 5; 10, 7.5; 10, 10;
                 15, 0; 15, 2.5; 15, 5; 15, 7.5; 15, 10;
                 20, 0; 20, 2.5; 20, 5; 20, 7.5; 20, 10;];
%drawingMesh(nodeCoordinates,elementNodes,'T6','k-o');
hold on
% GDof: global number of degrees of freedom
GDof = 2*numberNodes; 
% boundary conditions 
prescribedDof = [1 2 3 4 5 6 7 8 9 10]';
% force vector 
force = zeros(GDof,1);
force(41)= -2500/3
force(43) = -5000/3; 
force(44) = 0;
force(47)=  5000/3
force(49) = 2500/3; 
% calculation of the system stiffness matrix
stiffness= formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness)
% solution
displacements = solution(GDof,prescribedDof,stiffness,force);
% output displacements
outputDisplacements(displacements, numberNodes, GDof);
% %stress&output
% for e=1:numberElements                           
%   numNodePerElement = length(elementNodes(e,:));
%   numEDOF = 2*numNodePerElement;
%   elementDof=zeros(1,numEDOF);
%   for i = 1:numNodePerElement
%       elementDof(2*i-1)=2*elementNodes(e,i)-1;
%       elementDof(2*i)=2*elementNodes(e,i);   
%   end
%   stress(e,:) = D*Bmatrix{e}*displacements(elementDof);
%   fprintf('\nStress in element %d\n',e)
%   fprintf('Sigma_xx : %.6f\n',stress(e,1))
%   fprintf('Sigma_yy : %.6f\n',stress(e,2))
%   fprintf('Sigma_xy : %.6f\n',stress(e,3))
% end
M = 1000;
disp = vec2mat(displacements,2)*M;
%drawingMesh(nodeCoordinates+disp,elementNodes,'T6','r-o');





