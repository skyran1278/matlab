function [ stress_gp_cell, stress_node_cell] = ...
    stressRecoveryQ8(displacements, numberElements,elementNodes, nodeCoordinates,D)
%STRESSRECOVERY Recover element stresses from Gauss points
[gaussWeights,gaussLocations]=gauss2d('2x2');
stress_gp_cell=cell(numberElements);
stress_node_cell=cell(numberElements);
for e=1:numberElements
    numNodePerElement = length(elementNodes(e,:));
    numEDOF = 2*numNodePerElement;
    elementDof=zeros(1,numEDOF);
    for i = 1:numNodePerElement
        elementDof(2*i-1)=2*elementNodes(e,i)-1;
        elementDof(2*i)=2*elementNodes(e,i);
    end
    stress_gp=zeros(size(gaussWeights,1),3);
    % cycle for Gauss point
    for q=1:size(gaussWeights,1)
        GaussPoint=gaussLocations(q,:);
        xi=GaussPoint(1);
        eta=GaussPoint(2);
        
        % shape functions and derivatives
        [~,naturalDerivatives]=shapeFunctionQ8(xi,eta);
        
        % Jacobian matrix, inverse of Jacobian,
        % derivatives w.r.t. x,y
        [~,~,XYderivatives]=Jacobian(nodeCoordinates(elementNodes(e,:),:),naturalDerivatives);
        
        % B matrix
        B=zeros(3,numEDOF);
        B(1,1:2:numEDOF) = XYderivatives(1,:);
        B(2,2:2:numEDOF) = XYderivatives(2,:);
        B(3,1:2:numEDOF) = XYderivatives(2,:);
        B(3,2:2:numEDOF) = XYderivatives(1,:);
        
        % stress at gauss point
        stress_gp(q,:) = (D*B*displacements(elementDof))';
    end
    recovMat=[1+0.5*sqrt(3) -0.5 1-0.5*sqrt(3) -0.5;
              (1+sqrt(3))/4 (1+sqrt(3))/4 (1-sqrt(3))/4 (1-sqrt(3))/4;
              -0.5 1+0.5*sqrt(3) -0.5 1-0.5*sqrt(3);
              (1-sqrt(3))/4 (1+sqrt(3))/4 (1+sqrt(3))/4 (1-sqrt(3))/4;
               1-0.5*sqrt(3) -0.5 1+0.5*sqrt(3) -0.5;
              (1-sqrt(3))/4 (1-sqrt(3))/4 (1+sqrt(3))/4 (1+sqrt(3))/4;
              -0.5 1-0.5*sqrt(3) -0.5 1+0.5*sqrt(3);
              (1+sqrt(3))/4 (1-sqrt(3))/4 (1-sqrt(3))/4 (1+sqrt(3))/4];
    stress_node=recovMat*stress_gp;
    stress_gp_cell{e}=stress_gp;
    stress_node_cell{e}=stress_node;
end
