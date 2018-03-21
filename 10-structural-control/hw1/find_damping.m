function [] = find_damping(file)

  TIME_COL = 1;
  DISP_COL = 2;
  ACCEL_COL = 3;
  BASE_COL = 4;


  El50AXBS_fileid = fopen('El50AXBS.txt', 'r');
  El50AXBS = fscanf(El50AXBS_fileid, '%f');

  EL50RFA_fileid = fopen('EL50RFA.txt', 'r');
  EL50RFA = fscanf(EL50RFA_fileid, '%f');

  EL50RFD_fileid = fopen('EL50RFD.txt', 'r');
  EL50RFD = fscanf(EL50RFD_fileid, '%f');


  damping_fileid = fopen(file, 'r');
  damping = fscanf(damping_fileid, '%f %f %f %f', [4 Inf]);
  damping = damping';
  damping(:, DISP_COL) = damping(:, DISP_COL) * 1000;
  damping(:, ACCEL_COL) = damping(:, ACCEL_COL) / 9.81;
  damping(:, BASE_COL) = damping(:, BASE_COL) / 9.81;


  figure;
  plot((1 : length(EL50RFA)) * 0.0125, EL50RFA, damping(:, TIME_COL), damping(:, ACCEL_COL), '--')
  figure;

  [~, El50AXBS_ampl] = fft_improve(El50AXBS, 0.0125);
  [EL50RFA_freq, EL50RFA_ampl] = fft_improve(EL50RFA, 0.0125);

  input_transfer_function = EL50RFA_ampl ./ El50AXBS_ampl;

  plot(EL50RFA_freq(2 : end), input_transfer_function(2 : end), '--');

  hold on;

  [damping_freq, damping_ampl] = fft_improve(damping(:, ACCEL_COL), 0.0125);
  [~, base_ampl] = fft_improve(damping(:, BASE_COL), 0.0125);

  output_transfer_function = damping_ampl ./ base_ampl;

  plot(damping_freq(2 : end), output_transfer_function(2 : end), '--');

  title(file);
  xlabel('f (Hz)');
  ylabel('Amplitude');
  legend('對照資料', 'ETABS');

  figure;

  [~, El50AXBS_ampl] = fft_improve(El50AXBS, 0.0125);
  [EL50RFD_freq, EL50RFD_ampl] = fft_improve(EL50RFD, 0.0125);

  input_transfer_function = EL50RFD_ampl ./ El50AXBS_ampl;

  plot(EL50RFD_freq(2 : end), input_transfer_function(2 : end), '--');

  hold on;

  [damping_freq, damping_ampl] = fft_improve(damping(:, DISP_COL), 0.0125);
  [~, base_ampl] = fft_improve(damping(:, BASE_COL), 0.0125);

  output_transfer_function = damping_ampl ./ base_ampl;

  plot(damping_freq(2 : end), output_transfer_function(2 : end), '--');

  title(file);
  xlabel('f (Hz)');
  ylabel('Amplitude');
  legend('對照資料', 'ETABS');

end

