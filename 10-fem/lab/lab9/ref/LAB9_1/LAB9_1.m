% clear memory
clear all; close all; clc;

%% initialize
% materials
E  = 3e4;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 33;
numberElements = 5.;
nodeCoordinates = [0,0;0.5,0;1,0;1.5,0;2,0;2.5,0;3,0;3.5,0;4,0;4.5,0;5,0;
                   0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
                   0,0.5;0.5,0.5;1,0.5;1.5,0.5;2,0.5;2.5,0.5;3,0.5;3.5,0.5;4,0.5;4.5,0.5;5,0.5];
IRnodeCoordinates = [0,0;0.25,0;0.5,0;1.25,0;2,0;2.75,0;3.5,0;4,0;4.5,0;4.75,0;5,0;
                   0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
                   0,0.5;0.75,0.5;1.5,0.5;1.75,0.5;2,0.5;2.25,0.5;2.5,0.5;3,0.5;3.5,0.5;4.25,0.5;5,0.5];

elementNodes = [1,3,25,23,2,14,24,12,13;
                3,5,27,25,4,16,26,14,15;
                5,7,29,27,6,18,28,16,17;
                7,9,31,29,8,20,30,18,19;
                9,11,33,31,10,22,32,20,21];            
%elementNodes = [1,2,3,14,25,24,23,12,13;3,4,5,16,27,26,25,14,15;5,6,7,18,29,28,27,16,17;7,8,9,20,31,30,29,18,19;9,10,11,22,33,32,31,20,21];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1,23,24,45];

% force vector 
force=zeros(GDof,1);
force(21) = -1200;
force(65) = 1200;

%% Q9
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);
figure(1)
plot(nodeCoordinates(12:22,1),displacements(24:2:44),'bo')
hold on
%% initialize
clear
% materials
E  = 3e4;     poisson = 0.30;  thickness = 1;

% matrix D
D=E/(1-poisson^2)*[1 poisson 0;poisson 1 0;0 0 (1-poisson)/2];

% mesh
numberNodes = 33;
numberElements = 5.;
% %nodeCoordinates = [0,0;0.5,0;1,0;1.5,0;2,0;2.5,0;3,0;3.5,0;4,0;4.5,0;5,0;
%                    0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
%                    0,0.5;0.5,0.5;1,0.5;1.5,0.5;2,0.5;2.5,0.5;3,0.5;3.5,0.5;4,0.5;4.5,0.5;5,0.5];
nodeCoordinates = [0,0;0.25,0;0.5,0;1.25,0;2,0;2.75,0;3.5,0;4,0;4.5,0;4.75,0;5,0;
                   0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
                   0,0.5;0.75,0.5;1.5,0.5;1.75,0.5;2,0.5;2.25,0.5;2.5,0.5;3,0.5;3.5,0.5;4.25,0.5;5,0.5];

elementNodes = [1,3,25,23,2,14,24,12,13;
                3,5,27,25,4,16,26,14,15;
                5,7,29,27,6,18,28,16,17;
                7,9,31,29,8,20,30,18,19;
                9,11,33,31,10,22,32,20,21];            
%elementNodes = [1,2,3,14,25,24,23,12,13;3,4,5,16,27,26,25,14,15;5,6,7,18,29,28,27,16,17;7,8,9,20,31,30,29,18,19;9,10,11,22,33,32,31,20,21];

% GDof: global number of degrees of freedom
GDof=2*numberNodes; 

% boundary conditions
prescribedDof = [1,23,24,45];

% force vector 
force=zeros(GDof,1);
force(21) = -1200;
force(65) = 1200;

%% Q9
% calculation of the system stiffness matrix
stiffness=formStiffness2D(GDof,numberElements,...
    elementNodes,numberNodes,nodeCoordinates,D,thickness);

% solution
displacements=solution(GDof,prescribedDof,stiffness,force);

% output displacements
outputDisplacements(displacements, numberNodes, GDof);
figure(1)
plot(nodeCoordinates(12:22,1),displacements(24:2:44),'rs')
hold on

%exact
figure(1)
x = 0:0.01:5;
exact = -600*x.^2/(2*E*1/12*1*0.5^3);
plot(x,exact,'k-')
hold on
xlabel('x')
ylabel('displacement')
legend('R-Q9','IR-Q9','exact')

