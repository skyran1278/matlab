classdef meshQ4Test < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(vars.cornerCoordinates, vars.xMesh, vars.yMesh);

            numberElementsExp = vars.numberElements;
            numberNodesExp = vars.numberNodes;
            elementNodesExp = vars.elementNodes;
            nodeCoordinatesExp = vars.nodeCoordinates;
            nodesExp = vars.nodes;
            flipNodesExp = vars.flipNodes;

            testCase.verifyEqual(numberElements, numberElementsExp);
            testCase.verifyEqual(numberNodes, numberNodesExp);
            testCase.verifyEqual(elementNodes, elementNodesExp);
            testCase.verifyEqual(nodeCoordinates, nodeCoordinatesExp);
            testCase.verifyEqual(nodes, nodesExp);
            testCase.verifyEqual(flipNodes, flipNodesExp);
        end
    end
end
