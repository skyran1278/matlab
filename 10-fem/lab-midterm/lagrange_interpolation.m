function shape_function = lagrange_interpolation(xe, x)
%
% lagrange interpolation.
%
% @since 2.0.0
% @param {array} [xe] �n������I�� lagrange.
% @param {sym} [x] �ܼƦW��.
% @return {symfun} [shape_function] shape function of x.
%

    shape_function = sym(zeros(size(xe)));

    for index = 1 : length(shape_function)
        xi = xe(index);
        xj = xe(xe ~= xi);
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
