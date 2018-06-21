function p_k = legendre_polynomials(k, x)
%
% Legendre polynomials recursion
% ���k
%
% @since 2.0.1
% @param {integer} [k] �ݭn�D�ĴX�� legendre polynomials.
% @param {sym} [x] �ܼƦW��.
% @return {symfun} [p_k] function of x - Legendre polynomials eqution.
%

    if k == 0
        p_k = 1;
    elseif k == 1
        p_k = x;
    else
        p_k = (2 * k - 1) / k * x * legendre_polynomials((k - 1), x) - (k - 1) / k * legendre_polynomials((k - 2), x);
    end

end