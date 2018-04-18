function [frequency, amplitude] = fft_improve(data, time_interval)
%
% improve fft matlab original function.
% 給作圖用很方便.
%
% @since 1.0.0
% @param {array} [data] 要轉換成頻率域的資料.
% @param {number} [time_interval] 時間間隔.
% @return {arry} [frequency] 頻率.
% @return {arry} [amplitude] 震幅.
%

  data_length = length(data);

  data_fft = fft(data);

  data_abs = abs(data_fft / data_length);

  data_half = data_abs(1 : fix(data_length / 2 + 1));

  data_half(2 : end - 1) = 2 * data_half(2 : end - 1);

  amplitude = data_half;

  frequency = 1 / time_interval * (0 : fix(data_length / 2) ) / data_length;

end
