classdef form_stiffness_2D < matlab.unittest.TestCase

    methods (Test)

        % function have_uniform_load_T3(testCase)

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
        %     % number_elements: number of elements
        %     number_elements = 2;

        %     % number_nodes: number of nodes
        %     number_nodes = 4;

        %     % generation of coordinates and connectivities
        %     % muti_element_nodes
        %     element_nodes = [1 3 2; 1 4 3];
        %     nodeCoordinates = [0, 0; 0, 10; 20, 10; 20, 0];

        %     drawing_mesh(nodeCoordinates, element_nodes, 'k-o');

        %     % G_dof: global number of degrees of freedom
        %     G_dof = 2 * number_nodes;

        %     % boundary conditions and solution
        %     % prescribed dofs
        %     prescribed_dof = [1 2 3 4]';

        %     % initial displacements
        %     % initial_settlement
        %     displacements = zeros(G_dof, 1);

        %     % force vector
        %     force = zeros(G_dof, 1);
        %     force(5) = 5000;
        %     force(7) = 5000;

        %     % calculation of the system stiffness matrix
        %     stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, nodeCoordinates, D, thickness);

        %     % solution
        %     displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

        %     exp_stiffness = [19780219.7802198, 0, -11538461.5384615, 5769230.76923077, 0, -10714285.7142857, -8241758.24175824, 4945054.94505495; 0, 35851648.3516484, 4945054.94505495, -32967032.9670330, -10714285.7142857, 0, 5769230.76923077, -2884615.38461538; -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857, -8241758.24175824, 5769230.76923077, 0, 0; 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484, 4945054.94505495, -2884615.38461538, 0, 0; 0, -10714285.7142857, -8241758.24175824, 4945054.94505495, 19780219.7802198, 0, -11538461.5384615, 5769230.76923077; -10714285.7142857, 0, 5769230.76923077, -2884615.38461538, 0, 35851648.3516484, 4945054.94505495, -32967032.9670330; -8241758.24175824, 5769230.76923077, 0, 0, -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857; 4945054.94505495, -2884615.38461538, 0, 0, 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484];
        %     % exp_force = [36; 48; 32];
        %     exp_displacements = [0; 0; 0; 0; 0.000609580998131839; 4.16333066453182e-06; 0.000663704296770750; 0.000104083266613291];
        %     % exp_stress = [-24.0000; -24.0000; -33.6000; -33.6000];

        %     testCase.verifyEqual(stiffness, exp_stiffness, 'RelTol', 1e-10);
        %     testCase.verifyEqual(displacements, exp_displacements, 'RelTol', 1e-10);
        %     % testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
        %     % testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        % end

        function node_load_T4(testCase)

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

            corner_coordinates = [0 0; 20 0; 0 10; 20 10;];
            x_mesh = 2;
            y_mesh = 1;
            [number_elements, number_nodes, element_nodes, nodeCoordinates, nodes, flip_nodes] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

            % G_dof: global number of degrees of freedom
            G_dof = 2 * number_nodes;

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = [1 2 7].';
            % prescribed_dof = reshape([2 * flip_nodes(:, 1) - 1, 2 * flip_nodes(:, 1)].', [], 1);

            % force vector
            force = zeros(G_dof, 1);
            force(2 * nodes(:, end) - 1) = 5000;

            % initial displacements
            % initial_settlement
            displacements = zeros(G_dof, 1);

            % calculation of the system stiffness matrix
            stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, nodeCoordinates, D, thickness);

            % solution
            displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

            exp_stiffness = [
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
            % exp_force = [36; 48; 32];
            exp_displacements = [
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
            % exp_stress = [-24.0000; -24.0000; -33.6000; -33.6000];

            testCase.verifyEqual(stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(displacements, exp_displacements, 'RelTol', 1e-10);
            % testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            % testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end

    end

end
