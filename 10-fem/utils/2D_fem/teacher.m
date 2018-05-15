% A Thin Plate Subjected to Uniform Traction
% Rectangular Element Implementation
% 2 elements
% clear memory

clear all;
clc;
close all;
% materials
E = 30e6; poisson = 0.30; thickness = 1;
% matrix D for plane stress
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];
% preprocessing
% numberElements: number of elements
numberElements = 2;
% numberNodes: number of nodes
numberNodes = 6;
% coordinates and connectivities
elementNodes=[1 2 5 4; 2 3 6 5];
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


function stiffness=formStiffnessRec(GDof,numberElements,...
    elementNodes,nodeCoordinates,D,thickness)
    % compute stiffness matrix
    % for plane stress rectangular elements
    stiffness=zeros(GDof);
    % 2 by 2 quadrature
    [gaussWeights,gaussLocations]=gauss2d('2x2');
    for e=1:numberElements
        numEDOF = 8;
        elementDof=zeros(1,numEDOF);
        for i = 1:4
            elementDof(2*i-1)=2*elementNodes(e,i)-1;
            elementDof(2*i)=2*elementNodes(e,i);
        end
        %
        % THIS IS A HACK: we assume node 1 and node 2 align
        % with x-axis and node 2 and node3 align with y-axis
        %
        a = 0.5*abs(nodeCoordinates(elementNodes(e,2),1) -nodeCoordinates(elementNodes(e,1),1));
        b = 0.5*abs(nodeCoordinates(elementNodes(e,3),2) -nodeCoordinates(elementNodes(e,2),2));
        % cycle for Gauss point

        for q=1:size(gaussWeights,1)
            GaussPoint=gaussLocations(q,:);
            xi=GaussPoint(1);
            eta=GaussPoint(2);

            % shape functions and derivatives
            [shapeFunction,naturalDerivatives]=shapeFunctionQ4(xi,eta);
            XYderivatives(1,:) = 1/a * naturalDerivatives(1,:);
            XYderivatives(2,:) = 1/b * naturalDerivatives(2,:);
            % B matrix
            B=zeros(3,numEDOF);
            B(1,1:2:numEDOF) = XYderivatives(1,:);
            B(2,2:2:numEDOF) = XYderivatives(2,:);
            B(3,1:2:numEDOF) = XYderivatives(2,:);
            B(3,2:2:numEDOF) = XYderivatives(1,:);

            % stiffness matrix
            stiffness(elementDof,elementDof)=...
            stiffness(elementDof,elementDof)+...
            thickness*a*b*B'*D*B*gaussWeights(q);
        end

    end
end

function [weights,locations]=gauss2d(option)
    % Gauss quadrature in 2D
    % option '2x2'
    % option '1x1'
    % locations: Gauss point locations
    % weights: Gauss point weights

    switch option
    case '2x2'

    locations=...
    [ -0.577350269189626 -0.577350269189626;
    0.577350269189626 -0.577350269189626;
    0.577350269189626 0.577350269189626;
    -0.577350269189626 0.577350269189626];
    weights=[ 1;1;1;1];

 case '1x1'

 locations=[0 0];
 weights=[4];
    end
 end % end function gauss2d

 % .............................................................
 function [shape,naturalDerivatives]=shapeFunctionQ4(xi,eta)
    % shape function and derivatives for Q4 elements
    % shape : Shape functions
    % naturalDerivatives: derivatives w.r.t. xi and eta
    % xi, eta: natural coordinates (-1 ... +1)

    shape=1/4*[ (1-xi)*(1-eta), (1+xi)*(1-eta), ...
    (1+xi)*(1+eta), (1-xi)*(1+eta)];
    naturalDerivatives=...
    1/4*[-(1-eta), 1-eta, 1+eta, -(1+eta);
    -(1-xi), -(1+xi), 1+xi, 1-xi];
    end % end function shapeFunctionQ4

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
         plot(nodeCoordinates(elementNodes(e,seg1),1),        nodeCoordinates(elementNodes(e,seg1),2),format)
         hold on
        end
        axis equal
        hold off
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
