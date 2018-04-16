function shape_function = shape_function_with_lagrange(xe)
%shape_function_with_lagrange - 回傳形狀函數
%
% Syntax: shape_function = shape_function_with_lagrange(xe)
%
% @since 1.1.0
% @param {xe}: [arrays]
% @return {shape_function}: [arrays] shape function
%

    syms x;

    shape_function = sym(ones(size(xe)));

    for index = 1 : length(shape_function)
        xi = xe(index);
        xj = xe(xe ~= xi);
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
