%................................................................

function [stiffness]=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness)

% compute stiffness matrix
% for plane stress T6 elements

stiffness=zeros(GDof);

% 2 by 2 quadrature
[gaussWeights,gaussLocations]=gauss2d('3');

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
    L1=GaussPoint(1);
    L2=GaussPoint(2);
    L3=GaussPoint(3);
    
% shape functions and derivatives
    [shapeFunction,naturalDerivatives]=shapeFunctionT6(L2,L3);

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
    stiffness(elementDof,elementDof)=...
        stiffness(elementDof,elementDof)+...
        B'*D*thickness*B*gaussWeights(q)*det(Jacob);    
  end  
end    
