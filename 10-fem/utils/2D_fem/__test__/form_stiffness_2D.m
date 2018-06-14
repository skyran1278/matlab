classdef formStiffness2D < matlab.unittest.TestCase

    methods (Test)

        % function haveUniformLoadT3(testCase)

        %     % A Thin Plate Subjected to Uniform Traction
        %     % T3 Implementation
        %     % 2 elements

        %     % materials
        %     % E: modulus of elasticity (N/m^2)
        %     E = 30e6;
        %     poisson = 0.3;
        %     thickness = 1;

        %     % 2D matrix D
        %     D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

        %     % preprocessing
        %     % numberElements: number of elements
        %     numberElements = 2;

        %     % numberNodes: number of nodes
        %     numberNodes = 4;

        %     % generation of coordinates and connectivities
        %     elementNodes = [1 3 2; 1 4 3];
        %     nodeCoordinates = [0, 0; 0, 10; 20, 10; 20, 0];

        %     drawingMesh(nodeCoordinates, elementNodes, 'k-o');

        %     % gDof: global number of degrees of freedom
        %     gDof = 2 * numberNodes;

        %     % boundary conditions and solution
        %     % prescribed dofs
        %     prescribedDof = [1 2 3 4]';

        %     % initial displacements
        %     displacements = zeros(gDof, 1);

        %     % force vector
        %     force = zeros(gDof, 1);
        %     force(5) = 5000;
        %     force(7) = 5000;

        %     % calculation of the system stiffness matrix
        %     stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

        %     % solution
        %     displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

        %     expStiffness = [19780219.7802198, 0, -11538461.5384615, 5769230.76923077, 0, -10714285.7142857, -8241758.24175824, 4945054.94505495; 0, 35851648.3516484, 4945054.94505495, -32967032.9670330, -10714285.7142857, 0, 5769230.76923077, -2884615.38461538; -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857, -8241758.24175824, 5769230.76923077, 0, 0; 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484, 4945054.94505495, -2884615.38461538, 0, 0; 0, -10714285.7142857, -8241758.24175824, 4945054.94505495, 19780219.7802198, 0, -11538461.5384615, 5769230.76923077; -10714285.7142857, 0, 5769230.76923077, -2884615.38461538, 0, 35851648.3516484, 4945054.94505495, -32967032.9670330; -8241758.24175824, 5769230.76923077, 0, 0, -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857; 4945054.94505495, -2884615.38461538, 0, 0, 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484];
        %     % expForce = [36; 48; 32];
        %     expDisplacements = [0; 0; 0; 0; 0.000609580998131839; 4.16333066453182e-06; 0.000663704296770750; 0.000104083266613291];
        %     % expStress = [-24.0000; -24.0000; -33.6000; -33.6000];

        %     testCase.verifyEqual(stiffness, expStiffness, 'RelTol', 1e-10);
        %     testCase.verifyEqual(displacements, expDisplacements, 'RelTol', 1e-10);
        %     % testCase.verifyEqual(actForce, expForce, 'RelTol', 1e-10);
        %     % testCase.verifyEqual(actStress, expStress, 'RelTol', 1e-10);

        % end

        function nodeLoadT4(testCase)

            % A Thin Plate Subjected to Uniform Traction
            % T3 Implementation
            % 2 elements

            % materials
            % E: modulus of elasticity (N/m^2)
            E = 30e6;
            poisson = 0.3;
            thickness = 1;

            % 2D matrix D
            D = E / (1 - poisson ^ 2) * [1, poisson, 0; poisson, 1, 0; 0, 0, (1 - poisson) / 2];

            cornerCoordinates = [0 0; 20 0; 0 10; 20 10;];
            xMesh = 2;
            yMesh = 1;
            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

            % gDof: global number of degrees of freedom
            gDof = 2 * numberNodes;

            % boundary conditions and solution
            % prescribed dofs
            prescribedDof = [1 2 7].';
            % prescribedDof = reshape([2 * flipNodes(:, 1) - 1, 2 * flipNodes(:, 1)].', [], 1);

            % force vector
            force = zeros(gDof, 1);
            force(2 * nodes(:, end) - 1) = 5000;

            % initial displacements
            displacements = zeros(gDof, 1);

            % calculation of the system stiffness matrix
            stiffness = formStiffness2D(gDof, numberElements, elementNodes, nodeCoordinates, D, thickness);

            % solution
            displacements = solution(gDof, prescribedDof, stiffness, force, displacements);

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
