function [ stress_gp_cell,node_gp_cell] = ...
    stress_gp(displacements, numberElements,elementNodes, nodeCoordinates,D,type)
%STRESSRECOVERY Recover element stresses from Gauss points
[gaussWeights,gaussLocations]=gauss_const_2D(9);
stress_gp_cell=cell(numberElements,1);
node_gp_cell=cell(numberElements,1);
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
        switch type
            case 'Q8'
                [shape,naturalDerivatives]=shapeFunctionQ8(xi,eta);
            case 'Q9'
                [shape,naturalDerivatives]=shapeFunctionQ9(xi,eta);
        end
        % Jacobian matrix, inverse of Jacobian,
        % derivatives w.r.t. x,y
        [~,~,XYderivatives]=form_jacobian(nodeCoordinates(elementNodes(e,:),:),naturalDerivatives);

        % B matrix
        B=zeros(3,numEDOF);
        B(1,1:2:numEDOF) = XYderivatives(1,:);
        B(2,2:2:numEDOF) = XYderivatives(2,:);
        B(3,1:2:numEDOF) = XYderivatives(2,:);
        B(3,2:2:numEDOF) = XYderivatives(1,:);

        % stress at gauss point
        stress_gp(q,:) = (D*B*displacements(elementDof))';
        node_gp(q,:) = shape*nodeCoordinates(elementNodes(e,:),:);
    end
    stress_gp_cell{e}=stress_gp;
    node_gp_cell{e}=node_gp;
end
