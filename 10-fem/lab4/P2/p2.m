clc; clear; close all;

% output_node_disp_and_stress_by_fem(1);
% output_node_disp_and_stress_by_fem(2);
% output_node_disp_and_stress_by_fem(4);
% output_node_disp_and_stress_by_fem(8);
output_node_disp_and_stress_by_fem(16);

% output_node_disp_and_stress_by_fem(1000);

% legend('1 element', '2 element', '4 element', '8 element', '16 element', 'exact solution', 'Location', 'northwest');
% title('displacement vs. from exact solution and from 1, 2, 4, 8, 16 elements');
% xlabel('x (m)');
% ylabel('displacement (m)');

% [node_1, disp_1] = output_node_disp_by_lagrange(1);
% [node_2, disp_2] = output_node_disp_by_lagrange(2);
% [node_4, disp_4] = output_node_disp_by_lagrange(4);
% [node_8, disp_8] = output_node_disp_by_lagrange(8);
[node_16, disp_16] = output_node_disp_by_lagrange(16);
plot(node_16, disp_16, '--o');
% plot(node_1, disp_1, node_2, disp_2, node_4, disp_4, node_8, disp_8, node_16, disp_16);

% legend('1 node', '2 node', '4 node', '8 node', '16 node', 'exact solution', 'Location', 'northwest');
% title('displacement vs. from exact solution and from 1, 2, 4, 8, 16 nodes');
% xlabel('x (m)');
% ylabel('displacement (m)');

% TODO: exact solution
% TODO: stress
function [] = output_node_disp_and_stress_by_fem(n)

    % E: modulus of elasticity (N/m^2)
    % L: length of bar (m)
    Ee = 70e9 * ones(1, n); % Pa
    L = 0.5; % m
    Le = L / n * ones(1, n); % m

    % number_elements: number of elements
    number_elements = n;

    % nodes_number: number of nodes
    nodes_number = n + 1;

    % generation of coordinates and connectivities
    element_nodes = [(1 : n); (2 : n + 1)].';
    node_coordinates = 0 : (L / n) : L;

    % A: area of cross section (m^2)
    A0 = 12.5e-4; % m2
    A = A0 * (1 + (((node_coordinates(1 : end - 1) + node_coordinates(2 : end)) / 2) / L));

    % for structure:
        % displacements: displacement vector
        % force : force vector
        % stiffness: stiffness matrix
    force = zeros(nodes_number, 1);
    stiffness = zeros(nodes_number, nodes_number);
    k = zeros(number_elements, 1);

    % applied load at node 2
    force(1) = -5000.0; % N

    for e = 1 : number_elements
        % elementDof: element degrees of freedom (Dof)
        elementDof = element_nodes(e, :);
        k(e) = Ee(e) * A(e) / Le(e);
        stiffness(elementDof, elementDof) = ...
            stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
    end

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = nodes_number;

    % solution
    GDof = nodes_number;
    displacements = solution(GDof, prescribedDof, stiffness, force);

    plot(node_coordinates, displacements, '-*');
    hold on;

end



