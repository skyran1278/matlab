classdef formStiffness2DTest < matlab.unittest.TestCase
    methods (Test)
        function lab10(testCase)

            vars = load('lab10.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

    end

end
