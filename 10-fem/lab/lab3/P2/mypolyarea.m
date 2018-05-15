function poly_area = mypolyarea(x, y)
%mypolyarea - compute poly_area of the polygon
%
% Syntax: poly_area = mypolyarea(x, y)

  multiple = @(prior, later) sum(prior(1 : end - 1) .* later(2 : end)) + prior(end) .* later(1);
  poly_area = 1 / 2 * abs(multiple(x, y) - multiple(y, x));

end
