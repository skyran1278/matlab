% clear memory
clear all; close all; clc;

%% (a)
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

% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness,'Q8','2x2');

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
%outputDisplacements(displacements, numberNodes, GDof);
for e=1:numberElements
    numNodePerElement = length(elementNodes(e,:));
    numEDOF = 2*numNodePerElement;
    elementDof=zeros(1,numEDOF);
    for i = 1:numNodePerElement
        elementDof(2*i-1)=2*elementNodes(e,i)-1;
        elementDof(2*i)=2*elementNodes(e,i);
    end

    xi  = -1:0.001:1;
    eta = -1:0.001:1;
    for i =1:length(xi)
        for j =1:length(eta)
            %shapeFunction, naturalDerivatives
            [shapeFunction,naturalDerivatives]=shapeFunctionQ8(xi(i),eta(j));
            [~,~,XYderivatives]=Jacobian(nodeCoordinates(elementNodes(e,:),:),naturalDerivatives);
            
            % B matrix
            B=zeros(3,numEDOF);
            B(1,1:2:numEDOF) = XYderivatives(1,:);
            B(2,2:2:numEDOF) = XYderivatives(2,:);
            B(3,1:2:numEDOF) = XYderivatives(2,:);
            B(3,2:2:numEDOF) = XYderivatives(1,:);

            %stress_xx, stress_yy, stress_xy
            stress(:,j) = D*B*displacements(elementDof);             
        end
        
        %shear force
        shearForce(i) = -(2*sum(stress(3,:))-stress(3,1)-stress(3,end))/2*((eta(end)-eta(1))/(length(eta)-1));
    end
    x = linspace(nodeCoordinates(elementNodes(e,7),1),nodeCoordinates(elementNodes(e,5),1),length(xi));
    
    %plot
    pointwise = plot(x,shearForce,'b--','linewidth',1.5);
    hold on
end

%% (b)
%nodal stress from gauss point extrapolation
[~, stress_node_cell] = ...
    stressRecoveryQ8(displacements, numberElements,elementNodes, nodeCoordinates,D);
%shear force
shearForce=[];
shearForce(1) = (stress_node_cell{1}(1,3)+stress_node_cell{1}(8,3))/2*(nodeCoordinates(elementNodes(1,8),2)-nodeCoordinates(elementNodes(1,1),2))...
               +(stress_node_cell{1}(8,3)+stress_node_cell{1}(7,3))/2*(nodeCoordinates(elementNodes(1,7),2)-nodeCoordinates(elementNodes(1,8),2));
for e =1:numberElements
    shearForce(e+1) = (stress_node_cell{e}(3,3)+stress_node_cell{e}(4,3))/2*(nodeCoordinates(elementNodes(e,4),2)-nodeCoordinates(elementNodes(e,3),2))...
                     +(stress_node_cell{e}(4,3)+stress_node_cell{e}(5,3))/2*(nodeCoordinates(elementNodes(e,5),2)-nodeCoordinates(elementNodes(e,4),2));
end
x = linspace(min(nodeCoordinates(:,1)),max(nodeCoordinates(:,1)),numberElements+1);
%plot
extraploated = plot(x,-shearForce,'r-','linewidth',1.5);
title('Shear Force')
xlabel('x-coordinate (mm)')
ylabel('Force, N')
legend([pointwise,extraploated],'pointwise','extraploated')
axis([0 40 -20 50])
