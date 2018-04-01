function poly_perim = mypolyperim(x, y)
%mypolyperim - compute the perimeter
%
% Syntax: [] = mypolyperim(x, y)

  poly_perim = sum(sqrt((x(1 : end - 1) - x(2 : end)) .^ 2 + (y(1 : end - 1) - y(2 : end)) .^ 2)) + sqrt((x(end) - x(1)) ^ 2 + (y(end) - y(1)) ^ 2);

end
