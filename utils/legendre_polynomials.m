function p_k = legendre_polynomials(k)
%
% Legendre polynomials recursion
%
% @since 1.0.0
% @param {integer} [k] 需要求第幾個 legendre polynomials.
% @return {function} [p_k] function of x - Legendre polynomials eqution.
%

    syms x;

    if k == 0
        p_k = 1;
    elseif k == 1
        p_k = x;
    else
        p_k = (2 * k - 1) / k * x * legendre_polynomials(k - 1) - (k - 1) / k * legendre_polynomials(k - 2);
    end

end
