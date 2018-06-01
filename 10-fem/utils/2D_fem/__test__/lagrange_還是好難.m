function f = lagrange(Q)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] 要對哪些點做 lagrange.
% @param {sym} [x] 變數名稱.
% @return {symfun} [shape_function] shape function of x.
%

    nodes = Q / 2;

    x = linspace(-1, 1, nodes);

    y = linspace(-1, 1, nodes);

    shape_1D_x = zeros(1, length(x));
    shape_1D_y = zeros(1, length(y));

    location = [1 1; 2 1; 3 1; 4 1; 4 2; 4 3; 4 4; 3 4; 2 4; 1 4; 1 3; 1 2; 2 2; 3 2; 2 3; 3 3;];

    f = @shape_function;

    function [shape] = shape_function(xi, eta)

        shape = zeros(1, Q);

        for index = 1 : Q

            xk = x(location(index, 1));
            xj = x(x ~= xk);
            shape_1D_x(1, k) = prod((xi - xj) ./ (xk - xj));

            yk = y(location(index, 2));
            yj = y(y ~= yk);
            shape_1D_y(1, k) = prod((eta - yj) ./ (yk - yj)); % broadcasting

            shape(index) = shape_1D_x .* shape_1D_y;

        end

    end

end
