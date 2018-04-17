classdef test_gauss_quadrature < matlab.unittest.TestCase
    methods (Test)

        function varibale_tast(testCase)

            syms x xe1 xe2;

            f(x) = x ^ 8 + sin(x / 2);

            ngp = 5;

            I(xe1, xe2) = gauss_quadrature(f, xe1, xe2, ngp);

            act_solution = double(I(-1, 1));

            exp_solution = double(int(f, x, -1, 1));

            testCase.verifyEqual(act_solution, exp_solution, 'RelTol', 1e-10);

        end


        function const_tast(testCase)

            syms x;

            f(x) = x ^ 2 + sin(x / 2);

            ngp = 2;

            act_solution = double(gauss_quadrature(f, -1, 1, ngp));

            exp_solution = double(int(f, x, -1, 1));

            testCase.verifyEqual(act_solution, exp_solution, 'RelTol', 1e-10);

        end

    end
end
