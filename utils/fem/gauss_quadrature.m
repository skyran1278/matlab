function I = gauss_quadrature(f, ngp, a, b)
%
% 數值解.
% 相容於 -1 1
% f 可以是矩陣
%
% @since 2.0.2
% @param {symfun} [f] 需要做積分的函數.
% @param {number} [ngp] integration points，ngp >= (p + 1) / 2.
% @param {number syms} [a] 下限.
% @param {number syms} [b] 上限.
% @return {function} [I] 數值積分函數.
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

    % 高斯累加
    for index = 1 : ngp

        % a = -1, b = 1, x = abscissa(index)
        x = (a + b) / 2 + abscissa(index) / 2 * (b - a);

        I_hat = I_hat + weight(index) * f(x);

    end

    I = J * I_hat;

end
