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

% TODO: exact solution
function [] = plot_disp(n)

    % E: modulus of elasticity (N/m^2)
    % L: length of bar (m)
    Ee = 70e9 * ones(1, n); % Pa
    L = 0.5; % m
    Le = L / n * ones(1, n); % m

    % numberElements: number of elements
    numberElements = n;

    % numberNodes: number of nodes
    numberNodes = n + 1;

    % generation of coordinates and connectivities
    elementNodes = [(1 : n); (2 : n + 1)].';
    nodeCoordinates = 0 : (L / n) : L;

    % A: area of cross section (m^2)
    A0 = 12.5e-4; % m2
    A = A0 * (1 + (((nodeCoordinates(1 : end - 1) + nodeCoordinates(2 : end)) / 2) / L));

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
        k(e) = Ee(e) * A(e) / Le(e);
        stiffness(elementDof, elementDof) = ...
            stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
    end

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = numberNodes;

    % solution
    GDof = numberNodes;
    displacements = solution(GDof, prescribedDof, stiffness, force);

    plot(nodeCoordinates, displacements);
    hold on;

end


% TODO: lagrange
function [] = plot_disp_lagrange(n)

    syms x;

    % E: modulus of elasticity (N/m^2)
    % L: length of bar (m)
    % A: area of cross section (m^2)
    E = 70e9; % Pa
    L = 0.5; % m
    A0 = 12.5e-4; % m2
    A(x) = A0 * (1 + (x / L));

    % numberElements: number of elements
    % numberElements = n;

    % numberNodes: number of nodes
    numberNodes = n + 1;

    % generation of coordinates and connectivities
    % elementNodes = [(1 : n); (2 : n + 1)].';
    nodeCoordinates = 0 : (L / n) : L;

    % A: area of cross section (m^2)
    % A0 = 12.5e-4; % m2
    % A = A0 * (1 + (((nodeCoordinates(1 : end - 1) + nodeCoordinates(2 : end)) / 2) / L));



    N = sym(ones(n + 1, 1));

    for i = 1 : length(N)
        xj = (nodeCoordinates(nodeCoordinates ~= nodeCoordinates(i)));
        N(i, 1) = simplify(prod((x - xj) ./ (nodeCoordinates(i) - xj))); % broadcasting
    end

    B = diff(N, x);

    K =

    % for structure:
        % displacements: displacement vector
        % force : force vector
        % stiffness: stiffness matrix
    force = zeros(numberNodes, 1);
    stiffness = zeros(numberNodes, numberNodes);
    % k = zeros(numberElements, 1);

    % applied load at node 2
    force(1) = -5000.0; % N

    % for e = 1 : numberElements
    %     % elementDof: element degrees of freedom (Dof)
    %     elementDof = elementNodes(e, :);
    %     k(e) = Ee(e) * A(e) / Le(e);
    %     stiffness(elementDof, elementDof) = ...
    %         stiffness(elementDof, elementDof) + k(e) * [1 -1; -1 1];
    % end

    % boundary conditions and solution
    % prescribed dofs
    prescribedDof = numberNodes;

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
