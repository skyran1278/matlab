function shape_function = shape_function_with_lagrange(xe)
%shape_function_with_lagrange - Description
%
% Syntax: shape_function = shape_function_with_lagrange(xe)
%
% Long description

    syms x;

    shape_function = sym(ones(size(xe)));

    for index = 1 : length(shape_function)
        xi = xe(index);
        xj = xe(xe ~= xi);
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
