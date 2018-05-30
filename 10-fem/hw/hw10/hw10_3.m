ngp = 4;
[weight, location] = gauss_const_2D('2x2');
b_matrix = cell(4);
for index = 1 : ngp

    stress_gp = zeros(ngp, 3);

    xi = location(index, 1);
    eta = location(index, 2);

    [~, diff_shape] = shape_function_Q4(xi, eta);

    B = zeros(3, 8);

    % x 0 x 0 ...
    B(1, 1 : 2 : 8) = diff_shape(1, :);

    % 0 y 0 y ...
    B(2, 2 : 2 : 8) = diff_shape(2, :);

    % y x y x ...
    B(3, 1 : 2 : 8) = diff_shape(2, :);
    B(3, 2 : 2 : 8) = diff_shape(1, :);

    b_matrix{index} = B;

end

(1 + sqrt(3) / 2) * b_matrix{1} + (- 1 / 2) * b_matrix{2} + (1 - sqrt(3) / 2) * b_matrix{3} + (- 1 / 2) * b_matrix{4}
