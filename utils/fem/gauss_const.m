function [abscissa, weight] = gauss_const(ngp)
%
% return gauss const.
%
% @since 1.0.0
% @param {number} [ngp] integration points.
% @return {array} [abscissa] location.
% @return {array} [weight] weights.
% @see legendre_polynomials
%

    % cal gauss_quadrature const
    syms x;

    abscissa = solve(legendre_polynomials(ngp) == 0);

    p(x) = legendre_polynomials(ngp - 1);

    weight = 2 * (1 - (abscissa .^ 2)) ./ ((ngp * p(abscissa)) .^ 2);

end
