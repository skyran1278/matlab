classdef mesh_Q4_test < matlab.unittest.TestCase

    methods (Test)

        function mesh_2x2(testCase)
            corner_coordinates = [0 0; 2 0.5; 2 1; 0 1];
            x_mesh = 2;
            y_mesh = 2;

            exp_element_nodes = [
                1 2 5 4;
                2 3 6 5;
                4 5 8 7;
                5 6 9 8;
            ];

            exp_node_coordinates = [
                0         0;
                1.0000    0.2500;
                2.0000    0.5000;
                    0    0.5000;
                1.0000    0.6250;
                2.0000    0.7500;
                    0    1.0000;
                1.0000    1.0000;
                2.0000    1.0000;
            ];

            [element_nodes, node_coordinates] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

            testCase.verifyEqual(element_nodes, exp_element_nodes);
            testCase.verifyEqual(node_coordinates, exp_node_coordinates);
        end


        function mesh_4x4(testCase)
            corner_coordinates = [0 0; 2 0.5; 2 1; 0 1];
            x_mesh = 4;
            y_mesh = 4;

            exp_element_nodes = [
                1     2     7     6;
                2     3     8     7;
                3     4     9     8;
                4     5    10     9;
                6     7    12    11;
                7     8    13    12;
                8     9    14    13;
                9    10    15    14;
               11    12    17    16;
               12    13    18    17;
               13    14    19    18;
               14    15    20    19;
               16    17    22    21;
               17    18    23    22;
               18    19    24    23;
               19    20    25    24;
            ];

            exp_node_coordinates = [
                0                  0;
                0.500000000000000  0.125000000000000;
                1                  0.250000000000000;
                1.50000000000000   0.375000000000000;
                2                  0.500000000000000;
                0                  0.250000000000000;
                0.500000000000000  0.343750000000000;
                1                  0.437500000000000;
                1.50000000000000   0.531250000000000;
                2                  0.625000000000000;
                0                  0.500000000000000;
                0.500000000000000  0.562500000000000;
                1                  0.625000000000000;
                1.50000000000000   0.687500000000000;
                2                  0.750000000000000;
                0                  0.750000000000000;
                0.500000000000000  0.781250000000000;
                1                  0.812500000000000;
                1.50000000000000   0.843750000000000;
                2                  0.875000000000000;
                0                  1;
                0.500000000000000  1;
                1                  1;
                1.50000000000000   1;
                2                  1;
            ];

            [element_nodes, node_coordinates] = mesh_Q4(corner_coordinates, x_mesh, y_mesh);

            testCase.verifyEqual(element_nodes, exp_element_nodes);
            testCase.verifyEqual(node_coordinates, exp_node_coordinates);
        end

    end

end
