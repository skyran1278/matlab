classdef meshQ4Test < matlab.unittest.TestCase

    methods (Test)

        function mesh2x2(testCase)
            cornerCoordinates = [0 0; 2 0.5; 0 1; 2 1;];
            xMesh = 2;
            yMesh = 2;

            expElementNodes = [
                1 2 5 4;
                2 3 6 5;
                4 5 8 7;
                5 6 9 8;
            ];

            expNodeCoordinates = [
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

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

            testCase.verifyEqual(elementNodes, expElementNodes);
            testCase.verifyEqual(nodeCoordinates, expNodeCoordinates);
        end


        function mesh4x4(testCase)
            cornerCoordinates = [0 0; 2 0.5; 0 1; 2 1;];
            xMesh = 4;
            yMesh = 4;

            expElementNodes = [
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

            expNodeCoordinates = [
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

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

            testCase.verifyEqual(elementNodes, expElementNodes);
            testCase.verifyEqual(nodeCoordinates, expNodeCoordinates);
        end

    end

end
