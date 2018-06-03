function f = lagrange_interpolation(nodes)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] 要對哪些點做 lagrange.
% @param {sym} [x] 變數名稱.
% @return {symfun} [shape_function] shape function of x.
%

    x = linspace(-1, 1, nodes);

    f = @create_shape_function;

    function f = create_shape_function(node)

        f = @shape_function;

        function output = shape_function(x)

        end
    end


    shape_function = sym(zeros(size(xe)));

    for index = 1 : length(shape_function)

        xi = xe(index);

        % 回傳不等於 xi 的
        xj = xe(xe ~= xi);

        % 連乘
        % 回傳 shape function
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
