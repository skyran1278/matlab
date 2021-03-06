

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 30e3;
poisson = 0.3;
thickness = 1;

% preprocessing
% number_elements: number of elements
% number_elements = 2;

% number_nodes: number of nodes
% number_nodes = 6;

% generation of coordinates and connectivities
% muti_element_nodes

% element_nodes = [1 2 5 4; 2 3 6 5];
% node_coordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
corner_coordinates = [0 0; 5 0; 0 0.5; 5 0.5;];
x_mesh = 5;
y_mesh = 1;
[number_elements, number_nodes, element_nodes, node_coordinates, nodes, flip_nodes] = mesh_Q8(corner_coordinates, x_mesh, y_mesh);

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [2 * nodes(end, 1) - 1, 2 * nodes(2, 1) - 1, 2 * nodes(2, 1), 2 * nodes(1, 1) - 1].';
% prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

% force vector
force = zeros(G_dof, 1);
% force(5) = 5000;
% force(11) = 5000;
force(2 * nodes(1, end) - 1) = 1200;
force(2 * nodes(end, end) - 1) = -1200;

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% �T�{�O�_�e��
% drawing_mesh(node_coordinates, element_nodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


% drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
output_displacements(displacements, number_nodes, G_dof);

[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

stress_upperline = zeros(number_elements * 3, 2);

index = 1 : 3;

for e = 1 : number_elements

    stress = stress_gp_cell{e, 1};
    location = stress_gp_cell{e, 2};

    stress_upperline(index, 1) = stress([4 7 3], 1);
    stress_upperline(index, 2) = location([4 7 3], 1);

    index = index + 3;

end

% figure;
plot(stress_upperline(:, 2), stress_upperline(:, 1), 'bs');
hold on;

% output_reaction(displacements, stiffness, prescribed_dof, force)

% [stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

% drawing_stress(element_nodes, node_coordinates, stress_gp_cell, stress_node_cell);

node_coordinates = [
    0 0; 0.25 0; 0.5 0; 1.25 0; 2 0; 2.75 0; 3.5 0; 4 0; 4.5 0; 4.75 0; 5 0;
    0 0.25; 1 0.25; 2 0.25; 3 0.25; 4 0.25; 5 0.25;
    0 0.5; 0.75 0.5; 1.5 0.5; 1.75 0.5; 2 0.5; 2.25 0.5; 2.5 0.5; 3 0.5; 3.5 0.5; 4.25 0.5; 5 0.5;
];

stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

stress_upperline = zeros(number_elements * 3, 2);

index = 1 : 3;

for e = 1 : number_elements

    stress = stress_gp_cell{e, 1};
    location = stress_gp_cell{e, 2};

    stress_upperline(index, 1) = stress([4 7 3], 1);
    stress_upperline(index, 2) = location([4 7 3], 1);

    index = index + 3;

end

plot(stress_upperline(:, 2), stress_upperline(:, 1), 'r^');
hold on;

x = 0 : 0.01 : 5;
M = 600;
b = 1;
h = 0.5;
I = 1 / 12 * b * h ^ 3;

displacements = - M * x .^ 2 / (2 * E * I);

y = location(4, 2) - 0.25;
stress = M * y / I * ones(1, length(x));

plot(x, stress, 'k-');

legend('R-Q9', 'IR-Q9', 'R-Q8', 'IR-Q8', 'exact', 'Location', 'northeast');
grid on;
