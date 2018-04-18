function I = gauss_quadrature(f, a, b, ngp)
%
% TODO: J not const condition.
% �ƭȸ�.
%
% @since 1.0.0
% @param {f}: symfun�A�ݭn���n�������.
% @param {a}: �U��.
% @param {b}: �W��.
% @param {ngp}: integration points�Angp >= (p + 1) / 2.
% @return {I}: �ƭȿn�����.
% @see legendre_polynomials
%

    % cal gauss_quadrature const
    syms x;

    abscissa = solve(legendre_polynomials(ngp) == 0);

    p(x) = legendre_polynomials(ngp - 1);

    weight = 2 * (1 - (abscissa .^ 2)) ./ ((ngp * p(abscissa)) .^ 2);

    % Jacobian
    J = (b - a) / 2;

    I_hat = sym(zeros(size(f)));

    for index = 1 : ngp
        x_subs = (a + b) / 2 + abscissa(index) / 2 * (b - a);
        I_hat = I_hat + weight(index) * f(x_subs);
    end

    I = J * I_hat;

end
