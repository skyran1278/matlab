classdef meshQ4Test < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            cornerCoordinates = [0 0; 60 0; 0 20; 60 20;];
            xMesh = 6;
            yMesh = 2;
            [numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

            expVariables = load('meshQ4TestLab7.mat');

            numberElementsExp = expVariables.numberElements;
            numberNodesExp = expVariables.numberNodes;
            elementNodesExp = expVariables.elementNodes;
            nodeCoordinatesExp = expVariables.nodeCoordinates;
            nodesExp = expVariables.nodes;
            flipNodesExp = expVariables.flipNodes;

            testCase.verifyEqual(numberElements, numberElementsExp);
            testCase.verifyEqual(numberNodes, numberNodesExp);
            testCase.verifyEqual(elementNodes, elementNodesExp);
            testCase.verifyEqual(nodeCoordinates, nodeCoordinatesExp);
            testCase.verifyEqual(nodes, nodesExp);
            testCase.verifyEqual(flipNodes, flipNodesExp);
        end
    end
end
