clc; clear; close all;

plot_disp(1);
plot_disp(2);
plot_disp(4);
plot_disp(8);
plot_disp(16);
plot_disp(1000);

legend('1 element', '2 element', '4 element', '8 element', '16 element', 'exact solution', 'Location', 'northwest');
title('displacement vs. from exact solution and from 1, 2, 4, 8, 16 elements');
xlabel('x (m)');
ylabel('displacement (m)');

function [] = plot_disp(n)

    syms x xe1 xe2;

    % E: modulus of elasticity (N/m^2)
    % A: area of cross section (m^2)
    % L: length of bar (m)
    E = 70e9 * ones(1, n); % Pa
    A0 = 12.5e-4; % cm2
    L = 0.5 / n * ones(1, n); % m
    total_L = n * L(1);
    % P = 5000; % N

    % numberElements: number of elements
    numberElements = n;

    % numberNodes: number of nodes
    numberNodes = n + 1;

    % generation of coordinates and connectivities
    elementNodes = [(1 : n); (2 : n + 1)].';
    nodeCoordinates = (0 : total_L / n : total_L);
    A = A0 * (1 + (((nodeCoordinates(1 : end - 1) + nodeCoordinates(2 : end)) / 2) ./ total_L));

    % for structure:
        % displacements: displacement vector
        % force : force vector
        % stiffness: stiffness matrix
    force = zeros(numberNodes, 1);
    stiffness = zeros(numberNodes, numberNodes);
    k = zeros(numberElements, 1);

    % applied load at node 2
    force(1) = -5000.0; % N

    for e = 1 : numberElements
        % elementDof: element degrees of freedom (Dof)
        elementDof = elementNodes(e, :);
        k(e) = E(e) * A(e) / L(e);
        stiffness(elementDof, elementDof) = ...
            stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
    end

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = [numberNodes];

    % solution
    GDof = numberNodes;
    displacements = solution(GDof, prescribedDof, stiffness, force);

    plot(nodeCoordinates, displacements);

    hold on;
    % xe = (0 : (L / n) : L);



    % N = sym(ones(n, 1));

    % for index = 1 : length(N)
    %     xj = (xe(xe ~= xe(index)));
    %     N(index, 1) = simplify(prod((x - xj) ./ (xe(index) - xj))); % broadcasting
    % end

    % B = diff(N, x);

    % for index = 1 : n

    % end

    % Ke = simplify(int(B.' * Ae * E * B, x, xe1, xe2));

end
