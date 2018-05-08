function [] = predict_model(file)

  TIME_COL = 1;
  DISP_X_COL = 2;
  ACCEL_X_COL = 3;
  DISP_Y_COL = 4;
  ACCEL_Y_COL = 5;


  damping_fileid = fopen(file, 'r');
  damping = fscanf(damping_fileid, '%f %f %f %f %f', [5 Inf]);
  damping = damping';
  damping(:, [DISP_X_COL, DISP_Y_COL]) = damping(:, [DISP_X_COL, DISP_Y_COL]) * 10;


  figure;

  plot(damping(:, TIME_COL), damping(:, DISP_X_COL), '--', damping(:, TIME_COL), damping(:, DISP_Y_COL), ':');

  title([file ' Disp']);
  xlabel('T (s)');
  ylabel('mm');
  legend('X', 'Y');


  figure;

  plot(damping(:, TIME_COL), damping(:, ACCEL_X_COL), '--', damping(:, TIME_COL), damping(:, ACCEL_Y_COL), ':');

  title([file ' Acce']);
  xlabel('T (s)');
  ylabel('gal');
  legend('X', 'Y');

end
