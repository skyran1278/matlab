classdef solutionTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements);

        end

    end

end
