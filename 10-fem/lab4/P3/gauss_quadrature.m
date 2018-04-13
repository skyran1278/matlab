function I = gauss_quadrature(f, a, b, ngp)
%gauss_quadrature - gauss quadrature
%
% Syntax: I = gauss_quadrature(ngp)
%
% Long description

    % gauss_quadrature const
    switch ngp
        case 3
            location = [-0.7745966692 0.7745966692 0];
            weight = [0.5555555556 0.5555555556 0.8888888889];
    end

    J = (b - a) / 2;

    I_hat = sym(zeros(size(f)));

    for index = 1 : ngp
        x_subs = (a + b) / 2 + location(index) / 2 * (b - a);
        I_hat = I_hat + weight(index) * f(x_subs);
    end

    I(a, b) = J * I_hat;

end
