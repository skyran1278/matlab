classdef formStiffness2DTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness);

        end

        function lab8_1(testCase)

            vars = load('lab8_1.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness);

        end

        function lab8_2(testCase)

            vars = load('lab8_2.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness);

        end

    end

end
