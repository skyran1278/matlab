%................................................................

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
  % THIS IS A HACK: we assume node 1 and node 2 align with x-axis and node 2 and node3 align with y-axis
  %
  a = 0.5*abs(nodeCoordinates(elementNodes(e,2),1) - nodeCoordinates(elementNodes(e,1),1));
  b = 0.5*abs(nodeCoordinates(elementNodes(e,3),2) - nodeCoordinates(elementNodes(e,2),2));
  % cycle for Gauss point
  for q=1:size(gaussWeights,1)                      
    GaussPoint=gaussLocations(q,:);                                                     
    xi=GaussPoint(1);
    eta=GaussPoint(2);
    
% shape functions and derivatives
    [shapeFunction,naturalDerivatives]=shapeFunctionQ4(xi,eta);
    XYderivatives(1,:) = 1/a * naturalDerivatives(1,:);
    XYderivatives(2,:) = 1/b * naturalDerivatives(2,:);
	
%  B matrix
    B=zeros(3,numEDOF);
    B(1,1:2:numEDOF)       = XYderivatives(1,:);        
    B(2,2:2:numEDOF)  = XYderivatives(2,:);
    B(3,1:2:numEDOF)       = XYderivatives(2,:);
    B(3,2:2:numEDOF)  = XYderivatives(1,:);
    
% stiffness matrix
    stiffness(elementDof,elementDof)=...
        stiffness(elementDof,elementDof)+...
        thickness*a*b*B'*D*B*gaussWeights(q);    
  end  
end    
