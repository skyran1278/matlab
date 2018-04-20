classdef test_gauss_quadrature < matlab.unittest.TestCase
    methods (Test)

        function varibale_subs_tast(testCase)

            syms x xe1 xe2;

            f(x) = x ^ 8 + sin(x / 2);

            ngp = 5;

            I(xe1, xe2) = gauss_quadrature(f, ngp, xe1, xe2);

            f(xe1, xe2) = int(f, x, xe1, xe2);

            for index = 1 : 100

                rand_1 = rand;
                rand_2 = rand;

                act_solution = double(I(rand_1, rand_2));

                exp_solution = double(f(rand_1, rand_2));

            end

            testCase.verifyEqual(act_solution, exp_solution, 'RelTol', 1e-10);

        end


        function const_tast(testCase)

            syms x;

            f(x) = x ^ 2 + sin(x / 2);

            ngp = 2;

            act_solution = double(gauss_quadrature(f, ngp));

            exp_solution = double(int(f, x, -1, 1));

            testCase.verifyEqual(act_solution, exp_solution, 'RelTol', 1e-10);

        end

    end
end
