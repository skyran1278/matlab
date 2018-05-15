function [frequency, amplitude] = fft_improve(data, time_interval)
%
% improve fft matlab original function.
% ���@�ϥΫܤ�K.
%
% @since 1.0.0
% @param {array} [data] �n�ഫ���W�v�쪺���.
% @param {number} [time_interval] �ɶ����j.
% @return {arry} [frequency] �W�v.
% @return {arry} [amplitude] �_�T.
%

  data_length = length(data);

  data_fft = fft(data);

  data_abs = abs(data_fft / data_length);

  data_half = data_abs(1 : fix(data_length / 2 + 1));

  data_half(2 : end - 1) = 2 * data_half(2 : end - 1);

  amplitude = data_half;

  frequency = 1 / time_interval * (0 : fix(data_length / 2) ) / data_length;

end
