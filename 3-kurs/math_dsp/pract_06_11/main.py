import numpy as np
import matplotlib.pyplot as plt

H_list      = [1, 0.4, 0.16, 0.05]
Omega_list  = [0, 0.25 * np.pi, 0.5 * np.pi, 0.75 * np.pi, np.pi]

H_abs_vals  = []

def h_summ(n_max, omega):
    re = 0
    im = 0

    for i in range(0, n_max):
        re += H_list[i] * np.cos(i * omega)
        im -= H_list[i] * np.sin(i * omega)

    return re, im

def h_abs(re, im):
    return np.sqrt(re**2 + im**2)

for i in range(0, len(Omega_list)):
    re, im = h_summ(len(H_list), Omega_list[i])

    h_abs_val = h_abs(re, im)
    H_abs_vals.append(h_abs_val)

    print(f"omega={Omega_list[i]} \t | \t re={re} \t | \t im={im} \t | \t h_abs={h_abs_val}")


plt.figure(figsize=(8, 6))
plt.stem(H_abs_vals)
plt.show()