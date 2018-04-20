% Isoparametric Formulation Implementation
% clear memory
clear all

% E: modulus of elasticity
% A: area of cross section
% L: length of bar
E=2e7; A=[1.5 2.5]; L=[1 1]; A0=1;

% numberElements: number of elements
numberElements=2;
% numberNodes: number of nodes
numberNodes=3;
% generation of coordinates and connectivities
elementNodes=[1 2;2 3];
nodeCoordinates=[0 1 2];
% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
force=zeros(numberNodes,1);
stiffness=zeros(numberNodes,numberNodes);
%traction
force(1)=20;
% computation of the system stiffness matrix and force vector
for e=1:numberElements;
  % elementDof: element degrees of freedom (Dof)
  elementDof=elementNodes(e,:) ;
  detJacobian=L(e)/2;
  invJacobian=1/detJacobian;
  ngp = 2;
  [w,xi]=gauss1d(ngp);
  xc=0.5*(nodeCoordinates(elementDof(1))+nodeCoordinates(elementDof(2)));
  for ip=1:ngp;
      [shape,naturalDerivatives]=shapeFunctionL2(xi(ip));
      B=naturalDerivatives*invJacobian;
      stiffness(elementDof,elementDof)=...
      stiffness(elementDof,elementDof)+ B'*B*w(ip)*detJacobian*E*A(e);
      force(elementDof)=force(elementDof)+...
          24*A(e)*shape'*detJacobian*w(ip);
  end
end

% boundary conditions and solution
% prescribed dofs
prescribedDof=[3];
% solution
GDof=numberNodes;
displacements=solution(GDof,prescribedDof,stiffness,force);
% output displacements/reactions
% display('Constant Area:')
% outputDisplacementsReactions(displacements,stiffness, ...
    % numberNodes,prescribedDof,force)

%stress
Coordinates = [];
stress = [];
for  e=1:numberElements;
    elementDof=elementNodes(e,:);
    stress(2*e-1:2*e) = E*B*displacements(elementDof);
    Coordinates = [Coordinates nodeCoordinates(elementDof)];
end

%exact solution
x=0:0.1:2;
u_exact=(48+8*log(3)-12.*x-6.*x.^2-8.*log(1+x))/(2*10^7);
s_exact=-12-12.*x-8./(1+x);


%This Lab
E=2e7; A=[1.5 2.5]; L=[1 1]; A0=1;

% numberElements: number of elements
numberElements=2;
% numberNodes: number of nodes
numberNodes=3;
% generation of coordinates and connectivities
elementNodes=[1 2;2 3];
nodeCoordinates=[0 1 2];
% for structure:
   % displacements: displacement vector
   % force : force vector
   % stiffness: stiffness matrix
force=zeros(numberNodes,1);
stiffness=zeros(numberNodes,numberNodes);
%traction
force(1)=20;
for e=1:numberElements;
  % elementDof: element degrees of freedom (Dof)
  elementDof=elementNodes(e,:) ;
  detJacobian=L(e)/2;
  invJacobian=1/detJacobian;
  ngp = 2;
  [w,xi]=gauss1d(ngp);
  xc=0.5*(nodeCoordinates(elementDof(1))+nodeCoordinates(elementDof(2)));
  for ip=1:ngp;
      [shape,naturalDerivatives]=shapeFunctionL2(xi(ip));
      B=naturalDerivatives*invJacobian;
      stiffness(elementDof,elementDof)=...
      stiffness(elementDof,elementDof)+ B'*B*w(ip)*detJacobian*E*A0*(xc+detJacobian*xi(ip)+1);
      force(elementDof)=force(elementDof)+...
          24*A0*(xc+detJacobian*xi(ip)+1)*shape'*detJacobian*w(ip);
  end
end

% boundary conditions and solution
% prescribed dofs
prescribedDof=[3];
% solution
GDof=numberNodes;
newdisplacements=solution(GDof,prescribedDof,stiffness,force);
% output displacements/reactions
% display('linear Area')
outputDisplacementsReactions(newdisplacements,stiffness, ...
    numberNodes,prescribedDof,force)

%stress
newCoordinates = [];
newstress = [];
for  e=1:numberElements;
    elementDof=elementNodes(e,:) ;
    newstress(2*e-1:2*e) = E*B*newdisplacements(elementDof);
    newCoordinates = [newCoordinates nodeCoordinates(elementDof)];
end

%displacement plot
figure(1)
plot(x,u_exact,'b-',nodeCoordinates,newdisplacements,'ro:')
title('displacement')
xlabel('x')
ylabel('displacement,u')
legend('exact','FEM constArea','FEM linearArea')
%stress plot
figure(2)
plot(x,s_exact,'b-',Coordinates,newstress,'ro:')
title('stress')
xlabel('x')
ylabel('stress,\sigma')
legend('exact','FEM constArea','FEM linearArea')
