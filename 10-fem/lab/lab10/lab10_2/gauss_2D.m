function [weight, location] = gauss_2D(gauss_point)
%
% Gauss quadrature in 2D.
%
% @since 3.2.1
% @param {number} [gauss_point] 1 4 8 9 12 16.
% @param {string} [schemes] corner first or along boundary.
% @return {array} [weight] Gauss point weight.
% @return {array} [location] Gauss point location.
%

    switch gauss_point

        case 3

        location = [ 1/3 1/3 1/3 ];
        weight = 1/2;

        case 6

        location = [
            1/2 1/2 0;
            0 1/2 1/2;
            1/2 0 1/2;
        ];
        weight = [1/6; 1/6; 1/6];

    end

end
