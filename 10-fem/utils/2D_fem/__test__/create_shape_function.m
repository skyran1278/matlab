function f = create_shape_function(nodes_number, k)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] �n������I�� lagrange.
% @param {sym} [x] �ܼƦW��.
% @return {symfun} [shape_function] shape function of x.
%

    % syms x; % be careful performance issue.
    % x = x;
    nodes = linspace(-1, 1, nodes_number);

    xi = nodes(k);

    % �^�Ǥ����� xi ��
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
