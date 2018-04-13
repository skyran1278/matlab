function [node_coordinates, displacements, stress] = output_node_disp_and_stress_by_fem(n)
%output_node_disp_and_stress_by_fem - for 1D 座標系統
%
% Syntax: [node_coordinates, displacements, stress] = output_node_disp_and_stress_by_fem(n)
%
% for 1D 座標系統。
% TODO: 下次應該可以把參數移出去，做得更 general 一點。
%
% @since 0.2.0
% @param {n}: 代表 1 個 element 切成 n 個 elements。
% @return {node_coordinates}: 節點。
% @return {displacements}: 位移。
% @return {stress}: 壓力。
%

    if nargin == 0
        n = 16;
    end
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
    Ae = A0 * (1 + (((node_coordinates(1 : end - 1) + node_coordinates(2 : end)) / 2) / L));

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
        k(e) = Ee(e) * Ae(e) / Le(e);
        stiffness(elementDof, elementDof) = ...
            stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
    end

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = nodes_number;

    % solution
    GDof = nodes_number;
    displacements = solution(GDof, prescribedDof, stiffness, force);

    % stress
    stress = zeros(nodes_number, 1);

    for e = 1 : number_elements
        k = Ee(e) * Ae(e) / Le(e) * [1 -1; -1 1];
        stress(e : e + 1) = abs(k * displacements(element_nodes(e, :)) / Ae(e));
    end

end
