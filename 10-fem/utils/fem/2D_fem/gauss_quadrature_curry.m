function f = gauss_quadrature_curry(option)
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

    [weight, location] = gauss_const_2D(option);

    ngp = size(gauss_weight, 1);

    % �^�� function gauss_quadrature
    f = @gauss_quadrature;

    function I = gauss_quadrature(f)
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

            I_hat = I_hat + weight(index) * f(xi, eta);

        end

        I = simplify(I_hat);

    end

end
