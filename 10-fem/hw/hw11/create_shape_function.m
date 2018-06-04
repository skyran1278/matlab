function f = create_shape_function(nodes, k)
%
% lagrange interpolation.
%
% @since 2.0.1
% @param {array} [xe] �n������I�� lagrange.
% @param {sym} [x] �ܼƦW��.
% @return {symfun} [shape_function] shape function of x.
%

    xi = nodes(k);

    % �^�Ǥ����� xi ��
    xj = nodes(nodes ~= xi);

    reducer = prod((xi - xj));

    f = @shape_function;

    function shape = shape_function(x)
        shape = prod((x - xj)) / reducer;
    end

end
