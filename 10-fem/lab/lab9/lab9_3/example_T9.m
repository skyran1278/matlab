clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 3e4;
poisson = 0.3;
thickness = 1;

% preprocessing
% number_elements: number of elements
number_elements = 5;

% number_nodes: number of nodes
number_nodes = 33;

% generation of coordinates and connectivities
% muti_element_nodes

element_nodes = [1,3,25,23,2,14,24,12,13;
3,5,27,25,4,16,26,14,15;
5,7,29,27,6,18,28,16,17;
7,9,31,29,8,20,30,18,19;
9,11,33,31,10,22,32,20,21];
node_coordinates = [0,0;0.5,0;1,0;1.5,0;2,0;2.5,0;3,0;3.5,0;4,0;4.5,0;5,0;
0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
0,0.5;0.5,0.5;1,0.5;1.5,0.5;2,0.5;2.5,0.5;3,0.5;3.5,0.5;4,0.5;4.5,0.5;5,0.5];
% corner_coordinates = [0 0; 20 0; 0 10; 20 10;];
% x_mesh = 5;
% y_mesh = 5;
% [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1,23,24,45].';
% prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

% force vector
force = zeros(G_dof, 1);
force(21) = -1200;
force(65) = 1200;
% force(2 * nodes(1, :)) = 5000;
% force(2 * nodes(1, 1)) = 2500;
% force(2 * nodes(1, end)) = 2500;

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% 確認是否畫對
% drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements)

for e = 1 : number_elements

    stress = stress_gp_cell{e};

end
% drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
% output_displacements(displacements, number_nodes, G_dof);

% gp_stess
stress_xx = [];
node_Coordinate = [];
[ stress_gp_cell,node_gp_cell] = ...
    stress_gp(displacements, number_elements,element_nodes, node_coordinates,D,'Q9');
for i = 1:number_elements
    stress_gp = stress_gp_cell{i};
    stress_xx = [stress_xx;stress_gp([3,4,7],1)];
    node_gp = node_gp_cell{i};
    node_Coordinate = [node_Coordinate;node_gp([3,4,7],1)];
end

figure(1)
plot(node_Coordinate,stress_xx,'bo')
hold on
Q9_R = plot(node_Coordinate,stress_xx,'bo');
hold on


node_coordinates = [0,0;0.25,0;0.5,0;1.25,0;2,0;2.75,0;3.5,0;4,0;4.5,0;4.75,0;5,0;
0,0.25;0.5,0.25;1,0.25;1.5,0.25;2,0.25;2.5,0.25;3,0.25;3.5,0.25;4,0.25;4.5,0.25;5,0.25;
0,0.5;0.75,0.5;1.5,0.5;1.75,0.5;2,0.5;2.25,0.5;2.5,0.5;3,0.5;3.5,0.5;4.25,0.5;5,0.5];

% ========================================================
% input have done
% input have done
% input have done
% ========================================================


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


% drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
% output_displacements(displacements, number_nodes, G_dof);
% output_reaction(displacements, stiffness, prescribed_dof, force)

% [stress_gp_cell, stress_node_cell] = stress_recovery_Q9(number_elements, element_nodes, node_coordinates, D, displacements);

% drawing_stress(element_nodes, node_coordinates, stress_gp_cell, stress_node_cell);
% gp_stess
stress_xx = [];
node_Coordinate = [];
[stress_gp_cell,node_gp_cell] = ...
    stress_gp(displacements, number_elements,element_nodes, node_coordinates,D,'Q9');
for i = 1:number_elements
    stress_gp = stress_gp_cell{i};
    stress_xx = [stress_xx;stress_gp([3,4,7],1)];
    node_gp = node_gp_cell{i};
    node_Coordinate = [node_Coordinate;node_gp([3,4,7],1)];
end

figure(1)
plot(node_Coordinate,stress_xx,'bo')
hold on
Q9_IR = plot(node_Coordinate,stress_xx,'bo');
hold on




% materials
% E: modulus of elasticity (N/m^2)
E = 3e4;
poisson = 0.3;
thickness = 1;

% preprocessing
% number_elements: number of elements
number_elements = 5;

% number_nodes: number of nodes
number_nodes = 28;

% generation of coordinates and connectivities
% muti_element_nodes

element_nodes = [1,2,3,13,20,19,18,12;
3,4,5,14,22,21,20,13;
5,6,7,15,24,23,22,14;
7,8,9,16,26,25,24,15;
9,10,11,17,28,27,26,16];
node_coordinates = [0,0;0.5,0;1,0;1.5,0;2,0;2.5,0;3,0;3.5,0;4,0;4.5,0;5,0;
0,0.25;1,0.25;2,0.25;3,0.25;4,0.25;5,0.25;
0,0.5;0.5,0.5;1,0.5;1.5,0.5;2,0.5;2.5,0.5;3,0.5;3.5,0.5;4,0.5;4.5,0.5;5,0.5];
% corner_coordinates = [0 0; 20 0; 0 10; 20 10;];
% x_mesh = 5;
% y_mesh = 5;
% [number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1,23,24,35].';
% prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

% force vector
force = zeros(G_dof, 1);
force(21) = -1200;
force(55) = 1200;
% force(2 * nodes(1, :)) = 5000;
% force(2 * nodes(1, 1)) = 2500;
% force(2 * nodes(1, end)) = 2500;

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% 確認是否畫對
% drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


% gp_stess
stress_xx = [];
node_Coordinate = [];
[ stress_gp_cell,node_gp_cell] = ...
    stress_gp(displacements, number_elements,element_nodes, node_coordinates,D,'Q8');
for i = 1:number_elements
    stress_gp = stress_gp_cell{i};
    stress_xx = [stress_xx;stress_gp([3,4,7],1)];
    node_gp = node_gp_cell{i};
    node_Coordinate = [node_Coordinate;node_gp([3,4,7],1)];
end

figure(1)
Q8_R = plot(node_Coordinate,stress_xx,'rs');
hold on


node_coordinates = [0,0;0.25,0;0.5,0;1.25,0;2,0;2.75,0;3.5,0;4,0;4.5,0;4.75,0;5,0;
0,0.25;1,0.25;2,0.25;3,0.25;4,0.25;5,0.25;
0,0.5;0.75,0.5;1.5,0.5;1.75,0.5;2,0.5;2.25,0.5;2.5,0.5;3,0.5;3.5,0.5;4.25,0.5;5,0.5];

% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

% gp_stess
stress_xx = [];
node_Coordinate = [];
[ stress_gp_cell,node_gp_cell] = ...
    stress_gp(displacements, number_elements,element_nodes, node_coordinates,D,'Q8');
for i = 1:number_elements
    stress_gp = stress_gp_cell{i};
    stress_xx = [stress_xx;stress_gp([3,4,7],1)];
    node_gp = node_gp_cell{i};
    node_Coordinate = [node_Coordinate;node_gp([3,4,7],1)];
end

figure(1)
Q8_IR = plot(node_Coordinate,stress_xx,'rs');
hold on


%exact
figure(1)
x = 0:0.01:5;
exact = 600*(0.443649167310371-0.25)/(1/12*0.5^3)*ones(1,length(x));
plot(x,exact,'k-')
hold on
xlabel('x-coordinates')
ylabel('\sigma_{xx}')
legend([Q9_R, Q8_R, Q9_IR, Q8_IR, EXACT], 'R-Q9','R-Q8','IR-Q9','IR-Q8','exact')
grid on
