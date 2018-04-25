classdef test_fem_1D < matlab.unittest.TestCase

    methods (Test)

        function have_uniform_load(testCase)

            syms x A(x) b(x);

            % E: modulus of elasticity (N/m^2)
            % A: area of cross section (m^2)
            % L: length of bar (m)
            E = [2e7 2e7];
            L = [1 1];

            force = [20; 0; 0];

            A0 = 1;
            A(x) = A0 * (1 + x);
            b(x) = 24 * A;

            % number_elements: number of elements
            number_elements = 2;

            % number_nodes: number of nodes
            number_nodes = 3;

            % generation of coordinates and connectivities
            element_nodes = [1 2; 2 3];
            node_coordinates = [0 1 2];

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = 3;

            displacements = [0; 0; 0];

            [act_stiffness, act_force, act_displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

            % output stress
            [~, act_stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, act_displacements);

            exp_stiffness = [30000000 -30000000 0; -30000000 80000000 -50000000; 0 -50000000 50000000];
            exp_force = [36; 48; 32];
            exp_displacements = [2.88000000000000e-06; 1.68000000000000e-06; 0];
            exp_stress = [-24.0000; -24.0000; -33.6000; -33.6000];

            testCase.verifyEqual(act_displacements, exp_displacements, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end

        function muti_element_nodes(testCase)

            syms x A(x) b(x);

            % E: modulus of elasticity (N/m^2)
            % A: area of cross section (m^2)
            % L: length of bar (m)
            E = [2e7 2e7];
            L = [1 1];

            force = [20; 0; 0; 0; 0];

            A0 = 1;
            A(x) = A0 * (1 + x);
            b(x) = 24 * A;

            % number_elements: number of elements
            number_elements = 2;

            % number_nodes: number of nodes
            number_nodes = 5;

            % generation of coordinates and connectivities
            element_nodes = [1 2 3; 3 4 5];
            node_coordinates = [0 0.5 1 1.5 2];

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = 5;

            displacements = [0; 0; 0; 0; 0];

            [act_stiffness, act_force, act_displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

            % output stress
            [~, act_stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, act_displacements);

            exp_stiffness = [
                56666666.6666667, -66666666.6666667, 10000000, 0, 0;
                - 66666666.6666667, 160000000, -93333333.3333333, 0, 0;
                10000000, -93333333.3333333, 186666666.666667, -120000000, 16666666.6666667;
                0, 0, -120000000, 266666666.666667, -146666666.666667;
                0, 0, 16666666.6666667, -146666666.666667, 130000000
            ];
            exp_force = [24; 24; 16; 40; 12];
            exp_displacements = [2.83908523908524e-06; 2.30254677754678e-06; 1.66216216216216e-06; 8.97972972972973e-07; 0];
            exp_stress = [-19.3846153846154; -23.5384615384615; -27.6923076923077; -27.8918918918919; -33.2432432432432; -38.5945945945946];

            testCase.verifyEqual(act_displacements, exp_displacements, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end


        function no_uniform_load(testCase)

            syms x A(x) b(x);

            % E: modulus of elasticity (N/m^2)
            % A: area of cross section (m^2)
            % L: length of bar (m)
            E = [2.1e11 2.1e11 2.1e11 2.1e11];
            L = [3 3 3 3];

            force = [0; 30000; 0; 0; 0];

            A0 = 3e-4;
            A(x) = A0;
            b(x) = 0;

            % number_elements: number of elements
            number_elements = 4;

            % number_nodes: number of nodes
            number_nodes = 5;

            % generation of coordinates and connectivities
            element_nodes = [1 2; 2 3; 2 4; 2 5];
            node_coordinates = [0 3 6 6 6];

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = [1; 3; 4; 5];

            % settlement
            displacements = [0; 0; 0; 0; 0];

            [act_stiffness, act_force, act_displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

            % output stress
            [~, act_stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, act_displacements);

            exp_stiffness = [
                21000000, -21000000, 0, 0, 0; -21000000, 84000000, -21000000, -21000000, -21000000; 0, -21000000, 21000000, 0, 0; 0, -21000000, 0, 21000000, 0; 0, -21000000, 0, 0, 21000000
            ];
            exp_force = [0; 30000; 0; 0; 0];
            exp_displacements = [0; 0.000357142857142857; 0; 0; 0];
            exp_stress = [25000000; 25000000; -25000000; -25000000; -25000000; -25000000; -25000000; -25000000];

            testCase.verifyEqual(act_displacements, exp_displacements, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end


        function initial_settlement(testCase)

            syms x A(x) b(x);

            % E: modulus of elasticity (N/m^2)
            % A: area of cross section (m^2)
            % L: length of bar (m)
            E = [2.1e11 2.1e11];
            L = [2 2];

            force = [0; -10000; 0];

            A0 = 4e-4;
            A(x) = A0;
            b(x) = 1;

            % number_elements: number of elements
            number_elements = 2;

            % number_nodes: number of nodes
            number_nodes = 3;

            % generation of coordinates and connectivities
            element_nodes = [1 2; 2 3];
            node_coordinates = [0 2 4];

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = [1; 3];

            % settlement
            displacements = [0; 0; 25e-3];

            [act_stiffness, act_force, act_displacements] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof, displacements);

            % output stress
            [~, act_stress] = output_stress_coordinate_and_stress(E, number_elements, element_nodes, node_coordinates, act_displacements);

            exp_stiffness = [
                42000000, -42000000, 0; -42000000, 84000000, -42000000; 0, -42000000, 42000000
            ];
            exp_force = [1; -9998; 1];
            exp_displacements = [0; 0.0123809761904762; 0.0250000000000000];
            exp_stress = [1300002500.00000; 1300002500.00000; 1324997500.00000; 1324997500.00000];

            testCase.verifyEqual(act_displacements, exp_displacements, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end

    end
end
