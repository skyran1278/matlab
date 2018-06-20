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

        case 3

            gaussLocations = [ 1/3 1/3 1/3 ];
            gaussWeights = 1/2;

        case 6

            gaussLocations = [
                1/2 1/2 0;
                0 1/2 1/2;
                1/2 0 1/2;
            ];
            gaussWeights = [1/6; 1/6; 1/6];
    end

end
