function [shape_function_with_x, diff_shape_function] = lagrange_interpolation(orders, x)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] �n������I�� lagrange.
% @param {sym} [x] �ܼƦW��.
% @return {symfun} [shape_function] shape function of x.
%

    nodes = linspace(-1, 1, orders);

    shape_function_with_x = sym(zeros(size(nodes)));

    nodes_length = length(nodes);

    for index = 1 : nodes_length

        xi = nodes(index);

        % �^�Ǥ����� xi ��
        xj = nodes(nodes ~= xi);

        % �s��
        % �^�� shape function
        shape_function_with_x(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

    diff_shape_function = diff(shape_function_with_x, x);

    % shape_function = @f;

    % function shape = f(x)

    %     for index = 1 : nodes_length

    %         xi = nodes(index);

    %         % �^�Ǥ����� xi ��
    %         xj = nodes(nodes ~= xi);

    %         % �s��
    %         % �^�� shape function
    %         shape(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    %     end

    % end

end
