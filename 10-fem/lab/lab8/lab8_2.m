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


% drawing_deform(node_coordinates, element_nodes, displacements);


% output displacements
% output_displacements(displacements, number_nodes, G_dof);

% output_reaction(displacements, stiffness, prescribed_dof, force)

[stress_gp_cell, stress_node_cell] = stress_recovery(number_elements, element_nodes, node_coordinates, D, displacements);

fprintf('Stresses at Gauss points\n');
fprintf('Element  gp             Sxx               Syy                Sxy\n');
for e = 1 : length(stress_gp_cell)

    stress = stress_gp_cell{e};

    for index = 1 : size(stress, 1)

        fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
    end

end

fprintf('Stresses nodal stresses\n');
fprintf('Element  node           Sxx               Syy                Sxy\n');
for e = 1 : length(stress_node_cell)

    stress = stress_node_cell{e};

    for index = 1 : size(stress, 1)

        fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
    end

end



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

            % fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
        end

        % for index = 1 : ngp

        %     xi = location(index, 1);
        %     eta = location(index, 2);

        %     [~, diff_shape] = shape_function_Q4(xi, eta);

        %     [~, ~, diff_shape_XY] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

        %     B = zeros(3, num_e_dof);

        %     B(1, 1 : 2 : num_e_dof) = diff_shape_XY(1, :);
        %     B(2, 2 : 2 : num_e_dof) = diff_shape_XY(2, :);
        %     B(3, 1 : 2 : num_e_dof) = diff_shape_XY(2, :);
        %     B(3, 2 : 2 : num_e_dof) = diff_shape_XY(1, :);

        %     stress = D * B * displacements(element_dof, 1);

        %     acc_stress(:, element_nodes(e, index)) = acc_stress(:, element_nodes(e, index)) + stress;

        %     average_count(element_nodes(e, index)) = average_count(element_nodes(e, index)) + 1;

        % end

    end

    fprintf('Average Nodal Stresses\n');
    fprintf('Node           Sxx               Syy                Sxy\n');

    average_stress = acc_stress ./ average_count;

    fprintf('%4d%20.4e%20.4e%20.4e\n', [(1 : 9); average_stress]);
