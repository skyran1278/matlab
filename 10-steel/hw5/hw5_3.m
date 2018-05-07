Ac = 240 * sqrt(2) / 0.9 / 3.3

Ac = 120;

beta_ = 1.1;

omega_ = 1.3;

Ry = 1.2;

Fy = 3.3;

Tmax = omega_ * Ry * Ac * Fy

Cmax = beta_ * omega_ * Ry * Ac * Fy

axial = (Tmax + Cmax) / sqrt(2) / 2

shear = (Cmax - Tmax) / sqrt(2) / 2

Moment = shear * 4

left_col = 3 * shear + 2 * Tmax / sqrt(2)

right_col = 3 * shear - 2 * Cmax / sqrt(2)
