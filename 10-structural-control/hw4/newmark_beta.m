function [u, v, a] = newmark_beta(ag, time_interval, damping_ratio, tn, method)
%
% newmark beta.
%
% @since 1.0.0
% @param {array} [ag] input ���a�_�O���ɸ��.
% @param {number} [time_interval] �ɶ����j.
% @param {number} [damping_ratio] ������.
% @param {number} [tn] �۵M�g��.
% @param {string} [method] 'average' or 'linear'.
% @return {array} [u] �첾.
% @return {array} [v] �t��.
% @return {array} [a] �[�t��.
% @see newmark_beta_calculation
%

    % average Acceleration Method
    gamma_ = 1 / 2;

    switch method

        % average Acceleration Method
        case 'average'
            beta_ = 1 / 4;

        % linear Acceleration Method
        case 'linear'
            beta_ = 1 / 6;

    end

    wn = (2 * pi) / tn;

    m = 10;
    c = 2 * damping_ratio * wn * m;
    k = (wn ^ 2) * m;

    p_t = - m * ag;

    u = zeros(size(p_t));
    v = zeros(size(p_t));
    a = zeros(size(p_t));

    a(1) = 1 / m * (p_t(1) - c * v(1) - k * u(1));

    ag_length = length(ag);

    for ag_index = 2 : ag_length

        dp = p_t(ag_index) - p_t(ag_index - 1);

        [u(ag_index), v(ag_index), a(ag_index)] = newmark_beta_calculation(m, c, k, u(ag_index - 1), v(ag_index - 1), a(ag_index -1), dp, time_interval, gamma_, beta_);

    end

end
