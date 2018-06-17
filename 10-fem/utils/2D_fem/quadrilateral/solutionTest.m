classdef solutionTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end

        function lab8_1(testCase)

            vars = load('lab8_1.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end

        function lab9_8IR(testCase)

            vars = load('lab9_8IR.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end
        function lab9_8R(testCase)

            vars = load('lab9_8R.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end
        function lab9_9IR(testCase)

            vars = load('lab9_9IR.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end
        function lab9_9R(testCase)

            vars = load('lab9_9R.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end

    end

end
