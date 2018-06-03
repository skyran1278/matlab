function [shape_function_with_x, diff_shape_function] = lagrange_interpolation(orders, x)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] 要對哪些點做 lagrange.
% @param {sym} [x] 變數名稱.
% @return {symfun} [shape_function] shape function of x.
%

    nodes = linspace(-1, 1, orders);

    shape_function_with_x = sym(zeros(size(nodes)));

    nodes_length = length(nodes);

    for index = 1 : nodes_length

        xi = nodes(index);

        % 回傳不等於 xi 的
        xj = nodes(nodes ~= xi);

        % 連乘
        % 回傳 shape function
        shape_function_with_x(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

    diff_shape_function = diff(shape_function_with_x, x);

    % shape_function = @f;

    % function shape = f(x)

    %     for index = 1 : nodes_length

    %         xi = nodes(index);

    %         % 回傳不等於 xi 的
    %         xj = nodes(nodes ~= xi);

    %         % 連乘
    %         % 回傳 shape function
    %         shape(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    %     end

    % end

end
