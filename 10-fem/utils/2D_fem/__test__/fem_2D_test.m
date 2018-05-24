classdef fem_2D_test < matlab.unittest.TestCase

    methods (Test)

        function have_uniform_load(testCase)

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

            % preprocessing
            % number_elements: number of elements
            number_elements = 2;

            % number_nodes: number of nodes
            number_nodes = 4;

            % generation of coordinates and connectivities
            % muti_element_nodes
            element_nodes = [1 3 2; 1 4 3];
            node_coordinates = [0, 0; 0, 10; 20, 10; 20, 0];

            drawing_mesh(node_coordinates, element_nodes, 'k-o');

            % G_dof: global number of degrees of freedom
            G_dof = 2 * number_nodes;

            % boundary conditions and solution
            % prescribed dofs
            prescribed_dof = [1 2 3 4]';

            % initial displacements
            % initial_settlement
            displacements = zeros(G_dof, 1);

            % force vector
            force = zeros(G_dof, 1);
            force(5) = 5000;
            force(7) = 5000;

            % calculation of the system stiffness matrix
            stiffness = form_stiffness_2D(G_dof, number_elements, element_nodes, node_coordinates, D, thickness);

            % solution
            displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements);

            exp_stiffness = [19780219.7802198, 0, -11538461.5384615, 5769230.76923077, 0, -10714285.7142857, -8241758.24175824, 4945054.94505495; 0, 35851648.3516484, 4945054.94505495, -32967032.9670330, -10714285.7142857, 0, 5769230.76923077, -2884615.38461538; -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857, -8241758.24175824, 5769230.76923077, 0, 0; 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484, 4945054.94505495, -2884615.38461538, 0, 0; 0, -10714285.7142857, -8241758.24175824, 4945054.94505495, 19780219.7802198, 0, -11538461.5384615, 5769230.76923077; -10714285.7142857, 0, 5769230.76923077, -2884615.38461538, 0, 35851648.3516484, 4945054.94505495, -32967032.9670330; -8241758.24175824, 5769230.76923077, 0, 0, -11538461.5384615, 4945054.94505495, 19780219.7802198, -10714285.7142857; 4945054.94505495, -2884615.38461538, 0, 0, 5769230.76923077, -32967032.9670330, -10714285.7142857, 35851648.3516484];
            % exp_force = [36; 48; 32];
            exp_displacements = [0; 0; 0; 0; 0.000609580998131839; 4.16333066453182e-06; 0.000663704296770750; 0.000104083266613291];
            % exp_stress = [-24.0000; -24.0000; -33.6000; -33.6000];

            testCase.verifyEqual(stiffness, exp_stiffness, 'RelTol', 1e-10);
            testCase.verifyEqual(displacements, exp_displacements, 'RelTol', 1e-10);
            % testCase.verifyEqual(act_force, exp_force, 'RelTol', 1e-10);
            % testCase.verifyEqual(act_stress, exp_stress, 'RelTol', 1e-10);

        end

    end
end
