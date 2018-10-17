import os
import math
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dataset_dir = os.path.dirname(os.path.abspath(__file__))

f_c_ = 350
s = 8.5
n_x = n_y = 4
A_c = 2025
n_sl = 4
b_cx = b_cy = 45
f_yh = 2800
d_sh = 1.27
A_sh = 1.27
A_sl = 5.07
epsilon_co = 0.002
epsilon_yh = 0.002
epsilon_shh = 14 * epsilon_yh
epsilon_hu = 0.14 + epsilon_shh
s_ = s - d_sh

rho_cc = n_sl * A_sl / A_c
A_c = b_cx * b_cy
A_cc = A_c * (1 - rho_cc)
k_e = 0.75
f_ly = n_y * A_sh * f_yh / (s * b_cx)
f_lx = n_x * A_sh * f_yh / (s * b_cy)
f_ly_ = k_e * f_ly
f_lx_ = k_e * f_lx
print(f_ly_ / f_c_, f_lx_ / f_c_)
rho_y = n_y * A_sh / (s * b_cy)
rho_x = n_x * A_sh / (s * b_cx)
rho_s = rho_x + rho_y
f_cc_ = 1.5 * f_c_
epsilon_cc = epsilon_co * (1 + 5 * (f_cc_ / f_c_ - 1))
E_sec = f_cc_ / epsilon_cc
E_c = 15000 * math.sqrt(f_c_)
r = E_c / (E_c - E_sec)
epsilon_cu = 0.004 + 1.4 * rho_s * f_yh * epsilon_hu / f_cc_
epsilon_c = np.linspace(0, epsilon_cu)
x = epsilon_c / epsilon_cc
f_c = f_cc_ * x * r / (r - 1 + x ** 2)

df = pd.read_excel(dataset_dir + '/HW_Mander Model.xls',
                   'Exp.Data', header=1, skipfooter=2)
# print(df[['strain', 'stress(kg/cm^2)']])
plt.figure()
df.plot(x='strain', y='stress(kg/cm^2)')
plt.plot(epsilon_c, f_c)
plt.legend(labels=['Exp.Data', 'Mander model'])
plt.show()
pass
