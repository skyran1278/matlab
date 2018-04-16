function p_k = legendre_poly(k)

    syms x;

    if k == 0
        p_k = 1;

    elseif k == 1
        p_k = x;

    else
        p_k = (2 * k - 1) / k * x * legendre_poly(k - 1) - (k - 1) / k * legendre_poly(k - 2);

    end

end
