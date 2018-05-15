function I = gauss_quadrature(f, ngp, a, b)
%
% 计秆.
% 甧 -1 1
% f 琌痻皚
%
% @since 2.0.1
% @param {symfun} [f] 惠璶暗縩だㄧ计.
% @param {number} [ngp] integration pointsngp >= (p + 1) / 2.
% @param {number syms} [a] .
% @param {number syms} [b] .
% @return {function} [I] 计縩だㄧ计.
% @see gauss_const
%

    % abscissa
    if nargin == 2
        a = - 1;
        b = 1;
    end

    % cal gauss_quadrature const
    [abscissa, weight] = gauss_const(ngp);

    % Jacobian
    % a = -1, b = 1, J = 1
    J = (b - a) / 2;

    I_hat = sym(zeros(size(f)));

    for index = 1 : ngp

        % a = -1, b = 1, x = abscissa(index)
        x = (a + b) / 2 + abscissa(index) / 2 * (b - a);

        I_hat = I_hat + weight(index) * f(x);

    end

    I = J * I_hat;

end
