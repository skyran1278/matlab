% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements
% clear memory and close all figures
clear all;
clc;
close all;
% materials
E = 30e6; poisson = 0.30; thickness = 1;
% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];
% preprocessing
% numberElements: number of elements
numberElements = 2;
% numberNodes: number of nodes
numberNodes = 4;
% coordinates and connectivities
elementNodes=[1 3 2; 1 4 3];
nodeCoordinates=[0, 0; 0, 10; 20, 10; 20, 0];
drawingMesh(nodeCoordinates,elementNodes,'T3','k-o');


% GDof: global number of degrees of freedom
GDof = 2*numberNodes;
% boundary conditions
prescribedDof = [1 2 3 4]';
displacements = zeros(GDof, 1);
% force vector
force = zeros(GDof,1);
force(5) = 5000;
force(7) = 5000;
% calculation of the system stiffness matrix
stiffness = formStiffness2D(GDof,numberElements,...
 elementNodes,numberNodes,nodeCoordinates,D,thickness);

 % solution
displacements=solution(GDof,prescribedDof,stiffness,force);
% output displacements
outputDisplacements(displacements, numberNodes, GDof);

function drawingMesh(nodeCoordinates, elementNodes, type, format)
    switch type
     case 'T3'
     seg1 = [1,2,3,1];
     case 'Q4'
     seg1 = [1,2,3,4,1];
     otherwise
    disp('Type is not supported yet')
    end
    for e = 1:length(elementNodes(:,1))
     plot(nodeCoordinates(elementNodes(e,seg1),1),    nodeCoordinates(elementNodes(e,seg1),2),format)
     hold on
    end
    axis equal
    hold off
end

function stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness)
   % compute stiffness matrix for T3 elements
   stiffness=zeros(GDof);
   for e=1:numberElements
    numNodePerElement = length(elementNodes(e,:));
    numEDOF = 2*numNodePerElement;
    elementDof=zeros(1,numEDOF);
    for i = 1:numNodePerElement
    elementDof(2*i-1)=2*elementNodes(e,i)-1;
    elementDof(2*i)=2*elementNodes(e,i);
    end

    % B matrix
    x1 = nodeCoordinates(elementNodes(e,1),1);
    y1 = nodeCoordinates(elementNodes(e,1),2);
    x2 = nodeCoordinates(elementNodes(e,2),1);
 y2 = nodeCoordinates(elementNodes(e,2),2);
 x3 = nodeCoordinates(elementNodes(e,3),1);
 y3 = nodeCoordinates(elementNodes(e,3),2);
 A = 1/2*det([1 x1 y1; 1 x2 y2; 1 x3 y3]);
 B = 1/(2*A).*[y2-y3 0 y3-y1 0 y1-y2 0;
 0 x3-x2 0 x1-x3 0 x2-x1;
 x3-x2 y2-y3 x1-x3 y3-y1 x2-x1 y1-y2];

% stiffness matrix
 stiffness(elementDof,elementDof)=...
 stiffness(elementDof,elementDof)+...
 A*thickness*B'*D*B;
end
end

function outputDisplacements...
 (displacements,numberNodes,GDof)
% output of displacements in tabular form
disp('Displacements')
jj=1:numberNodes; format
f=[jj; displacements(1:2:GDof)'; displacements(2:2:GDof)'];
fprintf('Node UX UY\n')
fprintf('%4d %10.4e %10.4e\n',f)
end
