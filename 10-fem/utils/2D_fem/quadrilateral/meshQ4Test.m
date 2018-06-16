classdef meshQ4Test < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(vars.cornerCoordinates, vars.xMesh, vars.yMesh);

            testCase.verifyEqual(numberElements, vars.numberElements);
            testCase.verifyEqual(numberNodes, vars.numberNodes);
            testCase.verifyEqual(elementNodes, vars.elementNodes);
            testCase.verifyEqual(nodeCoordinates, vars.nodeCoordinates);
            testCase.verifyEqual(nodes, vars.nodes);
            testCase.verifyEqual(flipNodes, vars.flipNodes);

        end

        function lab8_1(testCase)

            vars = load('lab8_1.mat');

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(vars.cornerCoordinates, vars.xMesh, vars.yMesh);

            testCase.verifyEqual(numberElements, vars.numberElements);
            testCase.verifyEqual(numberNodes, vars.numberNodes);
            testCase.verifyEqual(elementNodes, vars.elementNodes);
            testCase.verifyEqual(nodeCoordinates, vars.nodeCoordinates);
            testCase.verifyEqual(nodes, vars.nodes);
            testCase.verifyEqual(flipNodes, vars.flipNodes);

        end

        function lab8_2(testCase)

            vars = load('lab8_2.mat');

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(vars.cornerCoordinates, vars.xMesh, vars.yMesh);

            testCase.verifyEqual(numberElements, vars.numberElements);
            testCase.verifyEqual(numberNodes, vars.numberNodes);
            testCase.verifyEqual(elementNodes, vars.elementNodes);
            testCase.verifyEqual(nodeCoordinates, vars.nodeCoordinates);
            testCase.verifyEqual(nodes, vars.nodes);
            testCase.verifyEqual(flipNodes, vars.flipNodes);

        end
    end
end
