function I = gauss_quadrature(f, a, b, ngp)
%gauss_quadrature - gauss quadrature
%
% Syntax: I = gauss_quadrature(ngp)
%
% 计秆
%
% @since 0.2.0
% @param {f}: symfun惠璶暗縩だㄧ计
% @param {a}: 
% @param {b}: 
% @param {ngp}: integration pointsngp >= (p + 1) / 2
% @return {I}: 计縩だㄧ计
%

    % gauss_quadrature const
    switch ngp
        case 1
            location = 0;
            weight = 2;
        case 2
            location = [- 1 / sqrt(3), 1 / sqrt(3)];
            weight = [1 1];
        case 3
            location = [-0.7745966692 0.7745966692 0];
            weight = [0.5555555556 0.5555555556 0.8888888889];
        case 4
            location = [-0.8611363116 0.8611363116 -0.3399810436 0.3399810436];
            weight = [0.3478548451 0.3478548451 0.6521451549 0.6521451549];
    end

    % Jacobian
    J = (b - a) / 2;

    I_hat = sym(zeros(size(f)));

    for index = 1 : ngp
        x_subs = (a + b) / 2 + location(index) / 2 * (b - a);
        I_hat = I_hat + weight(index) * f(x_subs);
    end

    I = J * I_hat;

end
