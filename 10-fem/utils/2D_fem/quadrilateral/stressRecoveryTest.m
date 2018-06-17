classdef stressRecoveryTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end

        function lab8_2(testCase)

            vars = load('lab8_2.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end

        function lab9_8IR(testCase)

            vars = load('lab9_8IR.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end
        function lab9_8R(testCase)

            vars = load('lab9_8R.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end
        function lab9_9IR(testCase)

            vars = load('lab9_9IR.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end
        function lab9_9R(testCase)

            vars = load('lab9_9R.mat');

            [stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.displacements);

            testCase.verifyEqual(stressGpCell, vars.stressGpCell, 'AbsTol', 1e-7);
            testCase.verifyEqual(stressNodeCell, vars.stressNodeCell, 'AbsTol', 1e-7);

        end

    end

end
