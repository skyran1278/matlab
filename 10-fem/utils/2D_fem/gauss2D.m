function [gaussWeights, gaussLocations] = gauss2D(gaussPoint, schemes)
%
% Gauss quadrature in 2D.
%
% @since 3.2.1
% @param {number} [gaussPoint] 1 4 8 9 12 16.
% @param {string} [schemes] corner first or along boundary.
% @return {array} [gaussWeights] Gauss point Weights.
% @return {array} [gaussLocations] Gauss point Locations.
%

    switch gaussPoint

        case {12, 16}

            loc = [-0.861136311594052, -0.339981043584856, 0.339981043584856, 0.861136311594052];
            w = [0.347854845137454, 0.652145154862546, 0.652145154862546, 0.347854845137454];

            if nargin == 1 || strcmp(schemes, 'cornerFirst')
                gaussLocations = [
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
                gaussWeights = [
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
            else
                gaussLocations = [
                    loc(1), loc(1);
                    loc(2), loc(1);
                    loc(3), loc(1);
                    loc(4), loc(1);
                    loc(4), loc(2);
                    loc(4), loc(3);
                    loc(4), loc(4);
                    loc(3), loc(4);
                    loc(2), loc(4);
                    loc(1), loc(4);
                    loc(1), loc(3);
                    loc(1), loc(2);
                    loc(2), loc(2);
                    loc(3), loc(2);
                    loc(3), loc(3);
                    loc(2), loc(3);
                ];
                gaussWeights = [
                    w(1) * w(1);
                    w(2) * w(1);
                    w(3) * w(1);
                    w(4) * w(1);
                    w(4) * w(2);
                    w(4) * w(3);
                    w(4) * w(4);
                    w(3) * w(4);
                    w(2) * w(4);
                    w(1) * w(4);
                    w(1) * w(3);
                    w(1) * w(2);
                    w(2) * w(2);
                    w(3) * w(2);
                    w(3) * w(3);
                    w(2) * w(3);
                ];
            end

        case {8, 9}

            w = [0.5555555556, 0.8888888889, 0.5555555556];

            if nargin == 1 || strcmp(schemes, 'cornerFirst')
                gaussLocations = sqrt(3 / 5) * [
                    -1, -1;
                     1, -1;
                     1,  1;
                    -1,  1;
                     0, -1;
                     1,  0;
                     0,  1;
                    -1,  0;
                     0,  0;
                ];
                gaussWeights = [
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
            else
                gaussLocations = sqrt(3 / 5) * [
                    -1, -1;
                     0, -1;
                     1, -1;
                     1,  0;
                     1,  1;
                     0,  1;
                    -1,  1;
                    -1,  0;
                     0,  0;
                ];
                gaussWeights = [
                    w(1) * w(1);
                    w(2) * w(1);
                    w(3) * w(1);
                    w(3) * w(2);
                    w(3) * w(3);
                    w(2) * w(3);
                    w(1) * w(3);
                    w(1) * w(2);
                    w(2) * w(2);
                ];
            end


        case 4

            gaussLocations = [
                - 1 / sqrt(3), - 1 / sqrt(3);
                  1 / sqrt(3), - 1 / sqrt(3);
                  1 / sqrt(3),   1 / sqrt(3);
                - 1 / sqrt(3),   1 / sqrt(3);
            ];

            gaussWeights = [1 1 1 1].';

        case 1

            gaussLocations = [0, 0];
            gaussWeights = 4;
    end

end
