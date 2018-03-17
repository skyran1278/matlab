% R06521217 ¤D«ÉµM °ªµ²HW2_4

function [ area ] = integral(a, b, deltax)

  f = @(x) 2 * x ^ 2 + 4 * x + 1;

  area = 0;

  x = a : deltax : b;

  for index = 1 : size(x, 2) - 1
    area = area + f(( x(index) + x(index + 1) ) / 2) * deltax;
  end


end
