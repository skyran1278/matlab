function shape_function = lagrange_interpolation(xe)
%
% lagrange interpolation.
%
% @since 1.0.0
% @param {array} [xe] 要對哪些點做 lagrange.
% @return {function} [shape_function] shape function of x.
% @see dependencies
%

    syms x;

    shape_function = sym(ones(size(xe)));

    for index = 1 : length(shape_function)
        xi = xe(index);
        xj = xe(xe ~= xi);
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
