classdef stressRecoveryTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell);

        end

        function lab8_2(testCase)

            vars = load('lab8_2.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell);

        end

    end

end
