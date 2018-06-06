function f = gauss_quadrature_curry(ngp)
%
% gauss quadrature curry 化.
% 加速用，省略 gauss_const 的過程，速度大幅提升。
% 我看到了閉包.
%
% @since 1.0.1
% @param {number} [ngp] integration points，ngp >= (p + 1) / 2.
% @return {function} [f] 回傳 gauss_quadrature.
% @see gauss_const, gauss_quadrature
%

    [abscissa, weight] = gauss_const(ngp);

    % 回傳 function gauss_quadrature
    f = @gauss_quadrature;

    function I = gauss_quadrature(f, ngp, a, b)
    %
    % 修改於 gauss_quadrature
    % 數值解.
    % 相容於 -1 1
    % f 可以是矩陣
    %
    % @since 2.0.1
    % @param {symfun} [f] 需要做積分的函數.
    % @param {number} [ngp] integration points，ngp >= (p + 1) / 2.
    % @param {number syms} [a] 下限.
    % @param {number syms} [b] 上限.
    % @return {function} [I] 數值積分函數.
    % @see gauss_quadrature
    %

        % abscissa
        if nargin == 2
            a = - 1;
            b = 1;
        end

        % f = matlabFunction(f);

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

end
