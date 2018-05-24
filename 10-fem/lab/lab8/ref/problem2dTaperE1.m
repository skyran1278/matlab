% Clamped Taper Plate with Vertical Traction
% Q4 Isoparametric Formulation Implementation
% 1 element
% clear memory
clear all; 
 
% materials
E  = 3*1e7;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];
 
% numberElements: number of elements
numberElements=1; 
% numberNodes: number of nodes
numberNodes=4;
% coordinates and connectivities
elementNodes=[1 2 3 4];
nodeCoordinates=[0,1; 0, 0; 2, 0.5; 2, 1];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);

% boundary conditions 
prescribedDof=[1 2 3 4]';

% force vector 
force=[0 -20 0 0 0 0 0 -20]';

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);

