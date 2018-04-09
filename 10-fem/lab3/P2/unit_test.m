clc; clear; close all;

test_polyarea_and_polyperim('Test #1: Square', [0; 1; 1; 0], [0; 0; 1; 1], 4);
test_polyarea_and_polyperim('Test #2: Equilateral Triangle', [-0.5; 0.5; 0], [0; 0; 0.8660255], 3);


function [] = test_polyarea_and_polyperim(test_title, x, y, exact_perimeter)

  fprintf(test_title);
  fprintf('\n* Coordinates:');

  ans_perimeter = mypolyperim(x, y);

  ans_area = mypolyarea(x, y);
  exact_area = polyarea(x,y);

  length_x = length(x);
  for index = 1 : length_x
    fprintf('\n Node %d : (%+.4f,%+.4f)', index, x(index), y(index));
  end

  fprintf('\n* Perimeter:');
  fprintf('\n mypolyperim(x,y)  = %.6f', ans_perimeter);
  fprintf('\n Exact perimeter   = %.6f', exact_perimeter);
  fprintf('\n Error (%%)        = %.6f', abs(ans_perimeter - exact_perimeter) / 100);

  fprintf('\n* Area:');
  fprintf('\n mypolyarea(x,y)   = %.6f', ans_area);
  fprintf('\n polyarea(x,y)     = %.6f', exact_area);
  fprintf('\n Error (%%)        = %.6f', abs(ans_area - exact_area) / 100);
  fprintf('\n');

end
