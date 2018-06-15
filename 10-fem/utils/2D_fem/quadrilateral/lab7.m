clc; clear; close all;

% materials
% E: modulus of elasticity (N/m^2)
E = 2e5;
poisson = 0.3;
thickness = 5;

% numberElements = 2;
% numberNodes = 6;
% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
cornerCoordinates = [0 0; 60 0; 0 20; 60 20;];
xMesh = 6;
yMesh = 2;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

% gDof: global number of degrees of freedom
gDof = 2 * numberNodes;

% boundary conditions and solution
% prescribed dof
% prescribedDof = [2 * nodes(end, 1) - 1, 2 * nodes(2, 1) - 1, 2 * nodes(2, 1), 2 * nodes(1, 1) - 1].';
prescribedDof = reshape([2 * nodes(:, end) - 1, 2 * nodes(:, end)].', [], 1);

% force vector
force = zeros(gDof, 1);
force(2 * nodes(2, 1)) = -1000;
% force(2 * nodes(1, 1)) = -0.375;
% force(2 * nodes(1, end)) = -0.375;


% initial displacements
displacements = zeros(gDof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

% drawingMesh(nodeCoordinates, elementNodes, 'k-o');

% 2D matrix D
D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

% calculation of the system stiffness matrix
stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

% solution
displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

drawingDeform(nodeCoordinates, elementNodes, displacements);

displacement_reshape = reshape(displacements, 2, []).';

x = 0 : 0.1: 60;
P = force(2 * nodes(2, 1));
h = 20;
I = 1 / 12 * thickness * h ^ 3;
L = 60;


uy = P * x .^ 3 / (6 * E * I) - P * L ^ 2 * x / (2 * E * I) + P * L ^ 3 / (3 * E * I);

figure;
plot(nodeCoordinates(nodes(2, :), 1), displacements(2 * nodes(2, :), 1), 'b-o', x, uy, 'r');
grid on;
xlabel('x(mm)');
ylabel('displacements(mm)');
title('neutral axis displacements(mm)');
legend({'FEM', 'exact'}, 'Location', 'southeast');

[stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

fprintf('Element Nodal Stresses\n');
fprintf('Element  Node           Sxx               Syy                Sxy\n');
for e = 1 : length(stressNodeCell)

    stress = stressNodeCell{e, 1};

    for index = 1 : size(stress, 1)

        fprintf('%4d%7d%20.4e%20.4e%20.4e\n', [e; index; stress(index, :).']);
    end

end

fprintf('Average Nodal Stresses\n');
fprintf('Node           Sxx               Syy                Sxy\n');

drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);
