function [weight, location] = gauss_const_2D(option)
%
% Gauss quadrature in 2D.
%
% @since 1.0.2
% @param {string} [option] '2x2', '1x1'.
% @return {array} [weight] Gauss point weight.
% @return {array} [location] Gauss point location.
%

    switch option

        case '4x4'
            loc = [-0.861136311594052, -0.339981043584856, 0.339981043584856, 0.861136311594052];
            w = [0.347854845137454, 0.652145154862546, 0.652145154862546, 0.347854845137454];
            location = [
                loc(1), loc(1);
                loc(4), loc(1);
                loc(4), loc(4);
                loc(1), loc(4);
                loc(2), loc(1);
                loc(3), loc(1);
                loc(4), loc(2);
                loc(4), loc(3);
                loc(3), loc(4);
                loc(2), loc(4);
                loc(1), loc(3);
                loc(1), loc(2);
                loc(2), loc(2);
                loc(3), loc(2);
                loc(3), loc(3);
                loc(2), loc(3);
            ];
            weight = [
                w(1) * w(1);
                w(4) * w(1);
                w(4) * w(4);
                w(1) * w(4);
                w(2) * w(1);
                w(3) * w(1);
                w(4) * w(2);
                w(4) * w(3);
                w(3) * w(4);
                w(2) * w(4);
                w(1) * w(3);
                w(1) * w(2);
                w(2) * w(2);
                w(3) * w(2);
                w(3) * w(3);
                w(2) * w(3);
            ];

        case '3x3'

            location = sqrt(3 / 5) * [
                - 1, - 1;
                  1, - 1;
                  1,   1;
                - 1,   1;
                  0, - 1;
                  1,   0;
                  0,   1;
                - 1,   0;
                  0,   0;
            ];
            w = [0.5555555556, 0.8888888889, 0.5555555556];
            weight = [
                w(1) * w(1);
                w(3) * w(1);
                w(3) * w(3);
                w(1) * w(3);
                w(2) * w(1);
                w(3) * w(2);
                w(2) * w(3);
                w(1) * w(2);
                w(2) * w(2);
            ];

        case '2x2'

            location = [
                - 1 / sqrt(3), - 1 / sqrt(3);
                  1 / sqrt(3), - 1 / sqrt(3);
                  1 / sqrt(3),   1 / sqrt(3);
                - 1 / sqrt(3),   1 / sqrt(3);
            ];

            weight = [1 1 1 1].';

        case '1x1'

            location = [0, 0];
            weight = [4];
    end

end
