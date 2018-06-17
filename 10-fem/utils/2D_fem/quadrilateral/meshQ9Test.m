classdef meshQ9Test < matlab.unittest.TestCase
    methods (Test)

        function lab9_9R(testCase)

            vars = load('lab9_9R.mat');

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ9(vars.cornerCoordinates, vars.xMesh, vars.yMesh);

            testCase.verifyEqual(numberElements, vars.numberElements);
            testCase.verifyEqual(numberNodes, vars.numberNodes);
            testCase.verifyEqual(elementNodes, vars.elementNodes);
            testCase.verifyEqual(nodeCoordinates, vars.nodeCoordinates);
            testCase.verifyEqual(nodes, vars.nodes);
            testCase.verifyEqual(flipNodes, vars.flipNodes);

        end
    end
end
