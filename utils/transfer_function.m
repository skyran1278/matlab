function [frequency, transfer_function] = transfer_function(input_data, output_data, time_interval)
%
% transfer function.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see fft_improve
%

    [~, input_amplitude] = fft_improve(input_data, time_interval);

    [frequency, output_amplitude] = fft_improve(output_data, time_interval);

    transfer_function = output_amplitude ./ input_amplitude;

end
