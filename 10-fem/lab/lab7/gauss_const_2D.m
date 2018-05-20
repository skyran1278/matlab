function [weight, location] = gauss_const_2D(option)
%
% Gauss quadrature in 2D.
%
% @since 1.0.1
% @param {string} [option] '2x2', '1x1'.
% @return {array} [weight] Gauss point weight.
% @return {array} [location] Gauss point location.
%

    switch option
        case '2x2'

            location = [
                -0.577350269189626, -0.577350269189626;
                 0.577350269189626, -0.577350269189626;
                 0.577350269189626,  0.577350269189626;
                -0.577350269189626,  0.577350269189626;
            ];

            weight = [1 1 1 1].';

        case '1x1'

            location = [0, 0];
            weight = [4];
    end

end