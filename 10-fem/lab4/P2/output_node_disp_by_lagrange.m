function [node_coordinates, displacements] = output_node_disp_by_lagrange(n)
%output_node_disp_by_lagrange - for 1D �y�Шt��
%
% Syntax: [node_coordinates, displacements] = output_node_disp_by_lagrange(n)
%
% for 1D �y�Шt�ΡC
% TODO: �U�����ӥi�H��ѼƲ��X�h�A���o�� general �@�I�C
%
% @since 0.1.2
% @param {n}: �N�� 1 �� element ���� n ���� lagrange�C
% @return {node_coordinates}: �`�I�C
% @return {displacements}: �첾�C
%

    syms x;

    % E: modulus of elasticity (N/m^2)
    % L: length of bar (m)
    % A: area of cross section (m^2)
    E = 70e9; % Pa
    L = 0.5; % m
    A0 = 12.5e-4; % m2
    A(x) = A0 * (1 + (x / L));

    % nodes_number: number of nodes
    node_number = n + 1;

    % generation of coordinates and connectivities
    node_coordinates = 0 : (L / n) : L;

    N = sym(ones(1, node_number));

    for index = 1 : length(N)
        xi = node_coordinates(index);
        xj = node_coordinates(node_coordinates ~= xi);
        N(1, index) = simplify(prod((x - xj) ./ (xi - xj))); % broadcasting
    end

    B = diff(N, x);

    % for structure:
        % force : force vector
        % stiffness: stiffness matrix
    force = zeros(node_number, 1);
    stiffness = int(B.' * A * E * B, x, 0, L);

    % applied load at node 2
    force(1) = -5000.0; % N

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = node_number;

    % solution
    GDof = node_number;
    displacements = solution(GDof, prescribedDof, stiffness, force);

end
