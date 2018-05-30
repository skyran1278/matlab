clc; clear; close all;

% A Thin Plate Subjected to Uniform Traction
% T3 Implementation
% 2 elements

% materials
% E: modulus of elasticity (N/m^2)
E = 30e6;
poisson = 0.3;
thickness = 1;

% preprocessing
% number_elements: number of elements
number_elements = 4;

% number_nodes: number of nodes
number_nodes = 9;

% generation of coordinates and connectivities
% muti_element_nodes

element_nodes = [1 2 5 4; 2 3 6 5; 4 5 8 7; 5 6 9 8];
node_coordinates = [0, 0; 1, 0.25; 2, 0.5; 0, 0.5; 1, 0.625; 2, 0.75; 0, 1; 1, 1; 2, 1];

% drawing_mesh(node_coordinates, element_nodes, 'k-o');

% G_dof: global number of degrees of freedom
G_dof = 2 * number_nodes;

% boundary conditions and solution
% prescribed dofs
prescribed_dof = [1 2 7 8 13 14].';

% initial displacements
% initial_settlement
displacements = zeros(G_dof, 1);

% force vector
force = zeros(G_dof, 1);
force(14) = - 10;
force(16) = - 20;
force(18) = - 10;

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];


% calculation of the system stiffness matrix
stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);


% solution
displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);


[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

% 一個 element 有幾個 nodes
num_node_per_element = size(element_nodes, 2);

% 一個 element 有幾個自由度
num_e_dof = 2 * num_node_per_element;
element_dof = zeros(1, num_e_dof);

[weight, location] = gauss_const_2D('2x2');

ngp = size(weight, 1);

acc_stress = zeros(3, 9);
average_count = zeros(1, 9);

for e = 1 : number_elements

    for index = 1 : num_node_per_element
        % x
        element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
        % y
        element_dof(2 * index) = 2 * element_nodes(e, index);
    end

    stress = stress_node_cell{e};

    for index = 1 : size(stress, 1)

        acc_stress(:, element_nodes(e, index)) = acc_stress(:, element_nodes(e, index)) + stress(index, :).';
        average_count(element_nodes(e, index)) = average_count(element_nodes(e, index)) + 1;

    end

end


average_stress = acc_stress ./ average_count;

drawing_patch(node_coordinates, element_nodes, average_stress(1, :))

title('\sigma_x_x');
xlabel('x(mm)');
ylabel('y(mm)');
axis([0 2 0 1.2]);
% axis([0 60 -25 25]);

figure;

for e = 1 : number_elements

    for index = 1 : num_node_per_element
        % x
        element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
        % y
        element_dof(2 * index) = 2 * element_nodes(e, index);
    end


    xi = 0;
    eta = 0;

    [~, diff_shape] = shape_function_Q4(xi, eta);

    [~, ~, diff_shape_XY] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

    B = zeros(3, num_e_dof);

    B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
    B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
    B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
    B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

    stress = D * B * displacements(element_dof, 1);

    patch(node_coordinates(element_nodes(e, :), 1), node_coordinates(element_nodes(e, :), 2), stress(1));

    hold on;


end

colormap jet;
colorbar;
title('\sigma_x_x');
xlabel('x(mm)');
ylabel('y(mm)');
axis([0 2 0 1.2]);


stress_ave = zeros(number_elements, 1);

for e = 1 : number_elements

    stress = stress_gp_cell{e};

    stress_average = mean(stress, 1);

    stress_ave(e) = stress_average(1);


end

drawing_patch(node_coordinates, element_nodes, stress_ave)
stress_ave

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    [weight, location] = gauss_const_2D('2x2');

    location = [-1 -1; 1 -1; 1 1; -1 1];

    ngp = size(weight, 1);



    for e = 1 : number_elements

        stress = zeros(3, 1);

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            [~, diff_shape] = shape_function_Q4(xi, eta);

            [~, ~, diff_shape_XY] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

            B = zeros(3, num_e_dof);

            B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
            B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
            B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

            stress = stress + D * B * displacements(element_dof, 1);

        end

        stress_ave(e) = stress(1) / 4;

    end

    drawing_patch(node_coordinates, element_nodes, stress_ave)
    stress_ave

stress_ave = zeros(number_elements, 1);

for e = 1 : number_elements

    stress = stress_node_cell{e};

    stress_average = mean(stress, 1);

    stress_ave(e) = stress_average(1);


end

drawing_patch(node_coordinates, element_nodes, stress_ave)
stress_ave
