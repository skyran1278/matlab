classdef quadrilateralTest < matlab.unittest.TestCase
    methods (Test)
        function nodeLoadT4(testCase)

            % materials
            % E: modulus of elasticity (N/m^2)
            E = 3e7;
            poisson = 0.3;
            thickness = 1;

            % numberElements = 2;
            % numberNodes = 6;
            % elementNodes = [1 2 5 4; 2 3 6 5];
            % nodeCoordinates = [0 0; 15 0; 20 0; 0 10; 15 10; 20 10];
            cornerCoordinates = [0 0; 40 0; 0 2; 40 2;];
            xMesh = 4;
            yMesh = 1;
            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ8(cornerCoordinates, xMesh, yMesh)

            % gDof: global number of degrees of freedom
            gDof = 2 * numberNodes;

            % boundary conditions and solution
            % prescribed dof
            % prescribedDof = [2 * nodes(end, 1) - 1, 2 * nodes(2, 1) - 1, 2 * nodes(2, 1), 2 * nodes(1, 1) - 1].';
            prescribedDof = reshape([2 * flipNodes(:, 1) - 1, 2 * flipNodes(:, 1)].', [], 1);

            % force vector
            force = zeros(gDof, 1);
            % force(2 * nodes(1, :)) = -0.75;
            % force(2 * nodes(1, 1)) = -0.375;
            % force(2 * nodes(1, end)) = -0.375;


            % initial displacements
            displacements = zeros(gDof, 1);

            % ========================================================
            % input have done
            % input have done
            % input have done
            % ========================================================

            drawingMesh(nodeCoordinates, elementNodes, 'k-o');

            % 2D matrix D
            D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

            % calculation of the system stiffness matrix
            stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

            % solution
            displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

            drawingDeform(nodeCoordinates, elementNodes, displacements);

            % output displacements
            outputDisplacements(displacements, numberNodes, gDof);


            outputReaction(displacements, stiffness, prescribedDof, force)

            [stressGpCell, stressNodeCell] = stressRecovery(numberElements, elementNodes, nodeCoordinates, D, displacements);

            drawingStress(elementNodes, nodeCoordinates, stressGpCell, stressNodeCell);


            expStiffness = [
                14835164.8351648, 5357142.85714286, -9065934.06593407, -412087.912087912, 0, 0, 1648351.64835165, 412087.912087912, -7417582.41758242, -5357142.85714286, 0, 0;
                5357142.85714286, 14835164.8351648, 412087.912087912, 1648351.64835165, 0, 0, -412087.912087912, -9065934.06593407, -5357142.85714286, -7417582.41758242, 0, 0;
                -9065934.06593407, 412087.912087912, 29670329.6703297, 1.16415321826935e-10, -9065934.06593407, -412087.912087912, -7417582.41758242, 5357142.85714286, 3296703.29670330, 0, -7417582.41758242, -5357142.85714286;
                -412087.912087912, 1648351.64835165, 2.32830643653870e-10, 29670329.6703297, 412087.912087912, 1648351.64835165, 5357142.85714286, -7417582.41758242, 0, -18131868.1318681, -5357142.85714286, -7417582.41758242;
                0, 0, -9065934.06593407, 412087.912087912, 14835164.8351648, -5357142.85714286, 0, 0, -7417582.41758242, 5357142.85714286, 1648351.64835165, -412087.912087912;
                0, 0, -412087.912087912, 1648351.64835165, -5357142.85714286, 14835164.8351648, 0, 0, 5357142.85714286, -7417582.41758242, 412087.912087912, -9065934.06593407;
                1648351.64835165, -412087.912087912, -7417582.41758242, 5357142.85714286, 0, 0, 14835164.8351648, -5357142.85714286, -9065934.06593407, 412087.912087912, 0, 0;
                412087.912087912, -9065934.06593407, 5357142.85714286, -7417582.41758242, 0, 0, -5357142.85714286, 14835164.8351648, -412087.912087912, 1648351.64835165, 0, 0;
                -7417582.41758242, -5357142.85714286, 3296703.29670330, 0, -7417582.41758242, 5357142.85714286, -9065934.06593407, -412087.912087912, 29670329.6703297, -4.65661287307739e-10, -9065934.06593407, 412087.912087912;
                -5357142.85714286, -7417582.41758242, 0, -18131868.1318681, 5357142.85714286, -7417582.41758242, 412087.912087912, 1648351.64835165, -4.65661287307739e-10, 29670329.6703297, -412087.912087912, 1648351.64835165;
                0, 0, -7417582.41758242, -5357142.85714286, 1648351.64835165, 412087.912087912, 0, 0, -9065934.06593407, -412087.912087912, 14835164.8351648, 5357142.85714286;
                0, 0, -5357142.85714286, -7417582.41758242, -412087.912087912, -9065934.06593407, 0, 0, 412087.912087912, 1648351.64835165, 5357142.85714286, 14835164.8351648;
            ];
            % expForce = [36; 48; 32];
            expDisplacements = [
                0;
                0;
                0.000333333333333334;
                1.56426694652989e-19;
                0.000666666666666667;
                2.92717419080235e-19;
                0;
                -0.000100000000000000;
                0.000333333333333334;
                -9.99999999999999e-05;
                0.000666666666666667;
                -9.99999999999997e-05;
            ];
            % expStress = [-24.0000; -24.0000; -33.6000; -33.6000];

            testCase.verifyEqual(stiffness, expStiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(displacements, expDisplacements, 'RelTol', 1e-10);
            % testCase.verifyEqual(actForce, expForce, 'RelTol', 1e-10);
            % testCase.verifyEqual(actStress, expStress, 'RelTol', 1e-10);

        end
    end
end
