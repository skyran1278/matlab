classdef gauss_quadrature_test < matlab.unittest.TestCase
    methods (Test)

        function varibale_tast(testCase)

            syms x xe1 xe2;

            f(x) = x ^ 2 + sin(x / 2);

            ngp = 2;

            I(xe1, xe2) = gauss_quadrature(f, xe1, xe2, ngp);

            act_solution = I(-1, 1);

            exp_solution = int(f, x, -1, 1);

            testCase.verifyEqual(act_solution, exp_solution);

        end


        function const_tast(testCase)

            syms x;

            f(x) = x ^ 2 + sin(x / 2);

            ngp = 2;

            act_solution = gauss_quadrature(f, -1, 1, ngp);

            exp_solution = int(f, x, -1, 1);

            testCase.verifyEqual(act_solution, exp_solution);

        end

    end
end
