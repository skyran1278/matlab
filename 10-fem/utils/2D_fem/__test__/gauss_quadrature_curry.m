function f = gauss_quadrature_curry(option, num_e_dof)
%
% gauss quadrature curry ��.
% �[�t�ΡA�ٲ� gauss_const ���L�{�A�t�פj�T���ɡC
% �ڬݨ�F���].
%
% @since 1.0.1
% @param {string} [option] '2x2', '1x1'.
% @return {function} [f] �^�� gauss_quadrature.
% @see gauss_const_2D
%
    syms xi eta;

    [weight, location] = gauss_const_2D(option);

    ngp = size(weight, 1);

    shape(xi, eta) = 1 / 4 * [ (1 - xi) * (1 - eta), (1 + xi) * (1 - eta), (1 + xi) * (1 + eta), (1 - xi) * (1 + eta)];

    diff_shape(xi, eta) = 1 / 4 * [
        - (1 - eta), 1 - eta, 1 + eta, - (1 + eta);
        - (1 - xi), - (1 + xi), 1 + xi, 1 - xi;
    ];

    diff_shape_XY = zeros(size(diff_shape));

    % �^�� function gauss_quadrature
    f = @gauss_quadrature;

    function I = gauss_quadrature(f, a, b)
    %
    % �ƭȸ�.
    % f �i�H�O�x�}
    %
    % @since 2.0.1
    % @param {symfun} [f] �ݭn���n�������.
    % @return {function} [I] �ƭȿn�����.
    % @see gauss_quadrature
    %

        I_hat = sym(zeros(size(f)));

        for index = 1 : ngp

            xi = location(index, 1);
            eta = location(index, 2);

            diff_shape_XY(1, :) = 1 / a * diff_shape(1, :);
            diff_shape_XY(2, :) = 1 / b * diff_shape(2, :);

            diff_shape = diff_shape(xi, eta);

            I_hat = I_hat + weight(index) * f(xi, eta);;
        end

        I = simplify(I_hat);

    end

end
