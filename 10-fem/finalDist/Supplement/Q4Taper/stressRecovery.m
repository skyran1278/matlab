function nodalStress = stressRecovery(nodeCoordinates, numberElements, elementNodes, D, displacements )
%STRESSRECOVERT Summary of this function goes here
%   Detailed explanation goes here

% 2 by 2 quadrature
[gaussWeights,gaussLocations]=gauss2d('2x2');
fprintf('Stresses at Gauss points\nElement   gp        Sxx            Syy            Sxy\n');
elementStress = zeros(4, 3);
nodalStress = zeros(4*numberElements, 3);

for e=1:numberElements                           
    numNodePerElement = length(elementNodes(e,:));
    numEDOF = 2*numNodePerElement;
    elementDof=zeros(1,numEDOF);
    for i = 1:numNodePerElement
        elementDof(2*i-1)=2*elementNodes(e,i)-1;
        elementDof(2*i)=2*elementNodes(e,i);   
    end

    % cycle for Gauss point
    for q=1:size(gaussWeights,1)                      
        GaussPoint=gaussLocations(q,:);                                                     
        xi=GaussPoint(1);
        eta=GaussPoint(2);

        % shape functions and derivatives
        [~,naturalDerivatives]=shapeFunctionQ4(xi,eta);

        % Jacobian matrix, inverse of Jacobian, 
        % derivatives w.r.t. x,y    
        [Jacob,invJacobian,XYderivatives]=...
            Jacobian(nodeCoordinates(elementNodes(e,:),:),naturalDerivatives);

        %  B matrix
        B=zeros(3,numEDOF);
        B(1,1:2:numEDOF)       = XYderivatives(1,:);        
        B(2,2:2:numEDOF)  = XYderivatives(2,:);
        B(3,1:2:numEDOF)       = XYderivatives(2,:);
        B(3,2:2:numEDOF)  = XYderivatives(1,:);

        % stiffness matrix
        stress = D * B * displacements(elementDof);
        fprintf('%5.0f  %5.0f  %13.4e  %13.4e  %13.4e\n', e, q, stress);
        elementStress(q, :) = stress;
    end  
    recovMat = [1+0.5*sqrt(3) -0.5 1-0.5*sqrt(3) -0.5;
        -0.5 1+0.5*sqrt(3) -0.5 1-0.5*sqrt(3);
        1-0.5*sqrt(3) -0.5 1+0.5*sqrt(3) -0.5;
        -0.5 1-0.5*sqrt(3) -0.5 1+0.5*sqrt(3)];
    nodalStress(numNodePerElement*e-(numNodePerElement-1):numNodePerElement*e, :) = recovMat*elementStress;
end

end

