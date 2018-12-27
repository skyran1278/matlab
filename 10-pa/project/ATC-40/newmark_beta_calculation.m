function [u, v, a] = newmark_beta_calculation(m, c, k, up, vp, ap, dp, dt, gamma_, beta_)
%
% newmark beta calculation
%
% @since 1.0.0
% @param {number} [m] 質量.
% @param {number} [c] 阻尼.
% @param {number} [k] 勁度.
% @param {number} [up] 前一個點的位移.
% @param {number} [vp] 前一個點的速度.
% @param {number} [ap] 前一個點的加速度.
% @param {number} [dp] 位移.
% @param {number} [dt] 時間間隔.
% @param {number} [gamma_] 常數.
% @param {number} [beta_] 常數.
% @return {number} [u] 位移.
% @return {number} [v] 速度.
% @return {number} [a] 加速度.
%

    %------------------
    % Calculate effective stiffness
    %------------------
    k_s = k + gamma_ / (beta_ * dt) * c + 1 / (beta_ * (dt ^ 2)) * m;

    %------------------
    % Compute coefficients a and b
    %------------------
    a = 1 / (beta_ * dt) * m + gamma_ / beta_ * c;
    b = 1 / (2 * beta_) * m + dt * (gamma_ / (2 * beta_) - 1) * c;

    %------------------
    % Calculate effective excitation and all responses
    %------------------
    dp_s = dp + a * vp + b * ap;

    %~~
    du = dp_s / k_s;

    %==
    dv = gamma_ / (beta_ * dt) * du - gamma_ / beta_ * vp - dt * (1 - gamma_ / (2 * beta_)) * ap;
    da = 1 / (beta_ * (dt ^ 2)) * du - 1 / (beta_ * dt) * vp - 1 / (2 * beta_) * ap;

    %~~
    u = up + du;
    v = vp + dv;
    a = ap + da;

end
