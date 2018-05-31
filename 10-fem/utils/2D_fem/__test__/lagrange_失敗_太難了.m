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

    f = @shape_function;

    function [shape] = shape_function(xi, eta)

        for index_x = 1 : nodes

            for index_y = 1 : nodes

                xk = x(k);
                yk = y(k);

                % 回傳不等於 xk 的
                xj = x(x ~= xk);
                yj = y(y ~= yk);

                % 連乘
                % 回傳 shape function
                shape_1D_x(1, k) = prod((xi - xj) ./ (xk - xj)); % broadcasting
                shape_1D_y(1, k) = prod((eta - yj) ./ (yk - yj)); % broadcasting

            end


        end

        shape = shape_1D_x .* shape_1D_y;

    end

end
