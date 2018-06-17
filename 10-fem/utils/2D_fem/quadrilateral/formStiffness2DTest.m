classdef formStiffness2DTest < matlab.unittest.TestCase
    methods (Test)
        function lab7(testCase)

            vars = load('lab7.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab8_1(testCase)

            vars = load('lab8_1.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab8_2(testCase)

            vars = load('lab8_2.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab9_8IR(testCase)

            vars = load('lab9_8IR.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab9_8R(testCase)

            vars = load('lab9_8R.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab9_9IR(testCase)

            vars = load('lab9_9IR.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

        function lab9_9R(testCase)

            vars = load('lab9_9R.mat');

            stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

            testCase.verifyEqual(stiffness, vars.stiffness, 'AbsTol', 1e-7);

        end

    end

end
