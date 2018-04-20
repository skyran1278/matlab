classdef test_fem_1D < matlab.unittest.TestCase

    methods (Test)

        function lab5(testCase)

            syms x;

            % E: modulus of elasticity (N/m^2)
            % A: area of cross section (m^2)
            % L: length of bar (m)
            E = [2e7 2e7];
            A = [1.5 2.5];
            L = [1 1];

            force = [20; 0; 0];

            A0 = 1;
            b(x) = 24 * A0 * (x + 1);

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

            [act_displacements, act_stiffness, act_force] = fem_1D(E, A, L, b, force, number_elements, number_nodes, element_nodes, node_coordinates, prescribed_dof);

            exp_displacements = [2.88000000000000e-06; 1.68000000000000e-06; 0];
            exp_stiffness = [30000000 -30000000 0; -30000000 80000000 -50000000; 0 -50000000 50000000];
            exp_force = [36; 48; 32];

            testCase.verifyEqual(act_displacements, exp_displacements, 'RelTol', 1e-10);
            testCase.verifyEqual(act_stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);

        end

    end
end



% % output displacements/reactions
% output_displacements_reactions(displacements, stiffness, number_nodes, prescribed_dof, force);

% % output element forces
% output_element_forces(E, A, L, number_elements, element_nodes, displacements);
