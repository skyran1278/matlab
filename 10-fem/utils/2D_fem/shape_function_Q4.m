function [shape, diff_shape] = shape_function_Q4(xi, eta)
%
% shape function and derivatives for Q4 elements.
%
% @since 1.0.0
% @param {sym} [xi] natural coordinates (-1 ... +1).
% @param {sym} [eta] natural coordinates (-1 ... +1).
% @param {array} [shape] Shape functions.
% @return {array} [diff_shape] derivatives w.r.t. xi and eta.
% @see dependencies
%

    shape = 1 / 4 * [ (1 - xi) * (1 - eta), (1 + xi) * (1 - eta), (1 + xi) * (1 + eta), (1 - xi) * (1 + eta)];

    diff_shape = 1 / 4 * [
        - (1 - eta), 1 - eta, 1 + eta, - (1 + eta);
        - (1 - xi), - (1 + xi), 1 + xi, 1 - xi;
    ];

end
