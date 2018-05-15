function [abscissa, weight] = gauss_const(ngp)
%
% return gauss const.
%
% @since 1.0.2
% @param {number} [ngp] integration points.
% @return {array} [abscissa] location.
% @return {array} [weight] weights.
% @see legendre_polynomials
%

    % cal gauss_quadrature const
    syms x p(x);

    % return xi use legendre_polynomials
    abscissa = solve(legendre_polynomials(ngp, x) == 0);

    % 得到 legendre_polynomials 用來算 weight
    p(x) = legendre_polynomials(ngp - 1, x);

    weight = 2 * (1 - (abscissa .^ 2)) ./ ((ngp * p(abscissa)) .^ 2);

end
