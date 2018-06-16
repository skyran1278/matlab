classdef formStiffness2DTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'RelTol', 1e-10);

        end

    end

end
