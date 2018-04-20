function [node_coordinates, displacements, stress] = exact_solution(E, A, L, b, cond_stress, cond_u)
%
% exact solution.
%
% @since 1.0.0
% @param {number} [E] modulus of elasticity (N/m^2).
% @param {sym} [A] area of cross section (m^2).
% @param {number} [L] length of bar (m).
% @param {sym} [b] internal force.
% @param {array} [cond_stress] boundary conditions [location value].
% @param {array} [cond_u] boundary conditions [location value].
% @return {array} [node_coordinates] node coordinates.
% @return {array} [displacements] displacements.
% @return {array} [stress] stress.
%

    syms x u(x);

    % A0 = 12.5e-4; % m2
    % L = 0.5; % m
    % E = 70e9; % pa = N / m2
    % P = -5000; % N
    % A(x) = A0 * (1 + (x / L));
    % b = 0;

    diff_u(x) = diff(u, x);

    cond_ = [E * diff_u(cond_stress(1)) == - cond_stress(2), u(cond_u(1)) == cond_u(2)];

    displacements(x) = dsolve(diff(A * E * diff_u) + b == 0, cond_);

    stress(x) = E * diff(displacements);

    node_coordinates = 0 : L / 1000 : L;

    displacements = displacements(node_coordinates);

    stress = stress(node_coordinates);

end
