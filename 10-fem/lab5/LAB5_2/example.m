% Isoparametric Formulation Implementation
% clear memory
clear
% E: modulus of elasticity
% A: area of cross section
% L: length of bar
E=20e6; A0=1; L=[1 1];
% numberElements: number of elements
numberElements=2;
% numberNodes: number of nodes
numberNodes=5;
% generation of coordinates and connectivities
elementNodes=[1 2 3; 3 4 5];
nodeCoordinates=0:0.5:2;
% for structure:
% displacements: displacement vector
% force : force vector
% stiffness: stiffness matrix
force=zeros(numberNodes,1);
stiffness=zeros(numberNodes,numberNodes);
% applied load at node 2
force(1)=20;
fnode = 24 * (nodeCoordinates' + 1);
% computation of the system stiffness matrix for Linear Area
for e=1:numberElements
% elementDof: element degrees of freedom (Dof)
elementDof=elementNodes(e,:) ;
detJacobian=L(e)/2;
invJacobian=1/detJacobian;
ngp = 3;
[w,xi]=gauss1d(ngp);
xc = (nodeCoordinates(elementNodes(e, end)) + nodeCoordinates(elementNodes(e,1))) / 2;
for ip=1:ngp
[shape,naturalDerivatives]=shapeFunctionL3(xi(ip));
B=naturalDerivatives*invJacobian;
x = xi(ip)*detJacobian + xc;
stiffness(elementDof,elementDof)=...
stiffness(elementDof,elementDof)+ B'*B*w(ip)*detJacobian*E*A0*(x+1);
force(elementDof) = force(elementDof) +shape'*24*(1+x)*w(ip)*detJacobian;
end
end
% boundary conditions and solution
% prescribed dofs
prescribedDof=[5];
% solution
GDof=numberNodes;
displacements=solution(GDof,prescribedDof,stiffness,force);
% output displacements/reactions
outputDisplacementsReactions(displacements,stiffness, ...
numberNodes,prescribedDof,force)
figure(1)
ezplot('(-12*x-6*x^2-8*log(1+x)+48+8*log(3))/20e6', [0 2]);
hold on
%plot Linear Area
disCoordinates = [];
quaDis = disCoordinates;
coor = linspace(-1, 1, 101);
for e=1:numberElements
detJacobian=L(e)/2;
xc = (nodeCoordinates(elementNodes(e, end)) + nodeCoordinates(elementNodes(e,1))) / 2;
dis = coor;
for p = 1:size(coor, 2)
[shape,~]=shapeFunctionL3(coor(p));
dis(p)=shape*displacements(elementNodes(e, :));
8
end
disCoordinates = [disCoordinates, (detJacobian*coor+xc)];
quaDis = [quaDis, dis];
end
plot(disCoordinates, quaDis, '--r');
legend('exact', 'FEM linearArea')
title('displacement')
ylabel('displacement,u')
xlabel('x')
hold off
%plot stresses
figure(2)
ezplot('-12-12*x-8/(1+x)', [0 2]);
hold on
%plot Linear Area
for e=1:numberElements
    sigma = zeros(1, 3);
    invJacobian=2/L(e);
    for ip = [-1 0 1]
        [~,naturalDerivatives]=shapeFunctionL3(ip);
        sigma(ip+2) = E * naturalDerivatives * displacements(elementNodes(e, :))*        invJacobian;
    end
    stress(3*e-2:3*e) = sigma;
    stressCoordinates(3*e-2:3*e) = nodeCoordinates(elementNodes(e, [1 2 3]));
end
plot(stressCoordinates, stress, '--or');
legend('exact', 'FEM linearArea')
title('stress')
ylabel('Axial stress,\sigma')
xlabel('x')
hold off
set(figure(1),'PaperUnits','centimeters','PaperPosition',[0,0,30,15])
print(figure(1),'-r600','-dtiff','Lab5_2_displacements.tiff');
set(figure(2),'PaperUnits','centimeters','PaperPosition',[0,0,30,15])
print(figure(2),'-r600','-dtiff','Lab5_2_stresses.tiff');
