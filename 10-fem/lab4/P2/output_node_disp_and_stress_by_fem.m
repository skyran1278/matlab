function [node_coordinates, displacements, stress] = output_node_disp_and_stress_by_fem(n)
%output_node_disp_and_stress_by_fem - for 1D �y�Шt��
%
% Syntax: [node_coordinates, displacements, stress] = output_node_disp_and_stress_by_fem(n)
%
% for 1D �y�Шt�ΡC
% TODO: �U�����ӥi�H��ѼƲ��X�h�A���o�� general �@�I�C
%
% @since 0.1.0
% @param {n}: �N�� 1 �� element ���� n ���C
% @return {node_coordinates}: �`�I�C
% @return {displacements}: �첾�C
% @return {stress}: ���O�C
%

    % E: modulus of elasticity (N/m^2)
    % L: length of bar (m)
    % Le: length of element (m)
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

    stiffness * displacements

end
