
% materials
% E: modulus of elasticity (N/m^2)
E = 30e3;
poisson = 0.3;
thickness = 1;

% numberElements = 2;
% numberNodes = 6;
% elementNodes = [1 2 5 4; 2 3 6 5];
% nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
% m
cornerCoordinates = [0 0; 5 0; 0 0.5; 5 0.5;];
xMesh = 5;
yMesh = 1;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ8(cornerCoordinates, xMesh, yMesh)

nodesX = 2 * nodes - 1;
nodesY = 2 * nodes;
flipNodesX = 2 * flipNodes - 1;
flipNodesY = 2 * flipNodes;

gDof = 2 * numberNodes;

% prescribed dof
prescribedDof = reshape([flipNodesX(:, 1); flipNodesY(2, 1)].', [], 1);

% force vector
% N
force = zeros(gDof, 1);
force(nodesX(1, end)) = 1200;
force(nodesX(end, end)) = -1200;


displacements = zeros(gDof, 1);

% ========================================================
% input have done
% input have done
% input have done
% ========================================================

D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

figure(1);
r8Displacement = plot(nodeCoordinates(nodes(2, nodes(2, :) > 0), 1), displacements(2 * nodes(2, nodes(2, :) > 0)), 'rs');
hold on;


[stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

stressUpperLine = zeros(numberElements * 3, 2);

index = 1 : 3;

for e = 1 : numberElements

    gpStress = stressGpCell{e, 1};
    gpLocation = stressGpCell{e, 2};

    stressUpperLine(index, 1) = gpStress([4 7 3], 1);
    stressUpperLine(index, 2) = gpLocation([4 7 3], 1);

    index = index + 3;

end

figure(2);
r8Stress = plot(stressUpperLine(:, 2), stressUpperLine(:, 1), 'rs');
hold on;
