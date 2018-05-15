function [node_coordinates, displacements, stress] = exact_solution()
%exact_solution - Description
%
% Syntax: [node_coordinates, displacements, stress] = exact_solution()
%
% Long description

    syms x u(x);

    A0 = 12.5e-4; % m2
    L = 0.5; % m
    E = 70e9; % pa = N / m2
    P = -5000; % N
    A(x) = A0 * (1 + (x / L));
    b = 0;

    diff_u(x) = diff(u, x);

    cond = [E * diff_u(0) == - P / A(0), u(L) == 0];

    displacements(x) = dsolve(diff(A * E * diff_u) + b == 0, cond);

    stress(x) = E * diff(displacements);

    node_coordinates = 0 : L / 16 : L;

    displacements = displacements(node_coordinates);

    stress = stress(node_coordinates);

end
