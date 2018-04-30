clc; clear; close all;

syms E v sigma_xx sigma_yy sigma_zz sigma_xy sigma_yz sigma_zx epsilon_xx epsilon_yy epsilon_zz gamma_xy gamma_yz gamma_zx;

D = E / ((1 + v) * (1 - 2 * v)) * [
    (1 - v), v, v, 0, 0, 0;
    v, (1 - v), v, 0, 0, 0;
    v, v, (1 - v), 0, 0, 0;
    0, 0, 0, (1 - 2 * v) / 2, 0, 0;
    0, 0, 0, 0, (1 - 2 * v) / 2, 0;
    0, 0, 0, 0, 0, (1 - 2 * v) / 2;
];

sigma = [sigma_xx; sigma_yy; sigma_zz; sigma_xy; sigma_yz; sigma_zx];

epsilon(epsilon_xx, epsilon_yy, epsilon_zz, gamma_xy, gamma_yz, gamma_zx) = [epsilon_xx; epsilon_yy; epsilon_zz; gamma_xy; gamma_yz; gamma_zx];

condense_factor = [
    1 0 0 0 0 0;
    0 1 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 1 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
];

D_plain_strain = D * condense_factor;

D_plain_strain = D_plain_strain([1 2 4], [1 2 4]);

simplify(D_plain_strain)


D_plain_stress = inv(D) * condense_factor;

D_plain_stress = D_plain_stress([1 2 4], [1 2 4]);

D_plain_stress = inv(D_plain_stress);

simplify(D_plain_stress)

