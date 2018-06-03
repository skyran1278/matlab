function f = create_shape_function(nodes_number, k)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] 要對哪些點做 lagrange.
% @param {sym} [x] 變數名稱.
% @return {symfun} [shape_function] shape function of x.
%

    % syms x; % be careful performance issue.
    % x = x;
    nodes = linspace(-1, 1, nodes_number);

    xi = nodes(k);

    % 回傳不等於 xi 的
    xj = nodes(nodes ~= xi);

    % g(x) = prod((x - xj) ./ (xi - xj));

    % f = @shape_function;

    % function shape = shape_function(x)
    %     shape = g(x);
    % end
    % g(x) = prod((x - xj) ./ (xi - xj));

    f = @shape_function;

    function shape = shape_function(x)
        shape = prod((x - xj) ./ (xi - xj));
    end

end
