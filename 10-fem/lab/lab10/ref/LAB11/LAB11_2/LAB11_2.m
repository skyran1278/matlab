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
numberElements = 2; 
% numberNodes: number of nodes
numberNodes = 9;
% coordinates and connectivities
elementNodes=[1 7 3 4 5 2; 3 7 9 5 8 6];
nodeCoordinates=[0, 0; 0, 5; 0, 10; 10, 0; 10, 5; 10, 10; 20, 0; 20, 5; 20,10];
drawingMesh(nodeCoordinates,elementNodes,'T6','k-o');
hold on
% GDof: global number of degrees of freedom
GDof = 2*numberNodes; 
% boundary conditions 
prescribedDof = [1 2 3 4 5 6]';
% force vector 
force = zeros(GDof,1);
force(13) = -5000/3; 
force(15) = 0;
force(17) = 5000/3;
% calculation of the system stiffness matrix
stiffness= formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);
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
drawingMesh(nodeCoordinates+disp,elementNodes,'T6','r-o');





