function f = gauss_quadrature_curry(option)
%
% gauss quadrature curry 化.
% 加速用，省略 gauss_const 的過程，速度大幅提升。
% 我看到了閉包.
%
% @since 1.0.1
% @param {string} [option] '2x2', '1x1'.
% @return {function} [f] 回傳 gauss_quadrature.
% @see gauss_const_2D
%

    [weight, location] = gauss_const_2D(option);

    ngp = size(gauss_weight, 1);

    % 回傳 function gauss_quadrature
    f = @gauss_quadrature;

    function I = gauss_quadrature(f)
    %
    % 數值解.
    % f 可以是矩陣
    %
    % @since 2.0.1
    % @param {symfun} [f] 需要做積分的函數.
    % @return {function} [I] 數值積分函數.
    % @see gauss_quadrature
    %

        I_hat = sym(zeros(size(f)));

        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            I_hat = I_hat + weight(index) * f(xi, eta);

        end

        I = simplify(I_hat);

    end

end
