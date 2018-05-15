function I = gauss_quadrature(f, ngp, a, b)
%
% �ƭȸ�.
% �ۮe�� -1 1
% f �i�H�O�x�}
%
% @since 2.0.2
% @param {symfun} [f] �ݭn���n�������.
% @param {number} [ngp] integration points�Angp >= (p + 1) / 2.
% @param {number syms} [a] �U��.
% @param {number syms} [b] �W��.
% @return {function} [I] �ƭȿn�����.
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

    % �����֥[
    for index = 1 : ngp

        % a = -1, b = 1, x = abscissa(index)
        x = (a + b) / 2 + abscissa(index) / 2 * (b - a);

        I_hat = I_hat + weight(index) * f(x);

    end

    I = J * I_hat;

end