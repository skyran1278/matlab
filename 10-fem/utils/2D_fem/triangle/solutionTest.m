classdef solutionTest < matlab.unittest.TestCase
    methods (Test)
        function lab10(testCase)

            vars = load('lab10.mat');

            displacements = solution(vars.gDof, vars.prescribedDof, vars.stiffness, vars.force, vars.displacements);

            testCase.verifyEqual(displacements, vars.displacements, 'AbsTol', 1e-7);

        end

    end

end
