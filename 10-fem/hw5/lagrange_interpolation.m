function shape_function = lagrange_interpolation(xe, x)
%
% lagrange interpolation.
%
% @since 2.0.0
% @param {array} [xe] 要對哪些點做 lagrange.
% @param {sym} [x] 變數名稱.
% @return {symfun} [shape_function] shape function of x.
%

    shape_function = sym(zeros(size(xe)));

    for index = 1 : length(shape_function)
        xi = xe(index);
        xj = xe(xe ~= xi);
        shape_function(1, index) = prod((x - xj) ./ (xi - xj)); % broadcasting
    end

end
