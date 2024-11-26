import numpy as np
import matplotlib.pyplot as plt


# t = np.linspace(0, 500, 5000)
#
# w1 = 100  # Гц
# A = 3    # Амплитуда
#
# S_t = A * np.cos(2 * np.pi * w1 * t)
#
# R = 10 ** 5
# C = 10 ** (-6)
#
# w = np.linspace(0, 500,
# H_jw = 1 / np.sqrt(1 + (w * R * C)**2)
# Fi_w = -np.arctan(w * R * C)
#
# plt.plot(w, H_jw)
# plt.title("Частотная характеристика фильтра")
# plt.xlabel("Частота (Гц)")
# plt.ylabel("|H(jw)|")
# plt.grid(True)
# plt.show()
#
# index_w1 = np.argmin(np.abs(w - w1))
#
# Y_t = A * H_jw[index_w1] * np.cos(2 * np.pi * w1 * t + Fi_w[index_w1])
#
# print(f"H(w1) = {H_jw[index_w1]}")
# print(f"Fi(w1) = {Fi_w[index_w1]}")
#
# plt.plot(t, S_t, label="Исходный сигнал")
# plt.plot(t, Y_t, label="Фильтрованный сигнал")
# plt.xlim(0, 500)
# plt.legend()
# plt.grid(True)
# plt.show(1000)

# Параметры RC-фильтра
R = 10**(5)  # Сопротивление, Ом
C = 10**(-6)  # Емкость, Фарад
omega = np.linspace(0, (2 * 2 * np.pi) / (R * C), 100)  # Частота

# Частотные характеристики
achh = 1 / (np.sqrt(1 + (omega * R * C)**2))  # Амплитудно-частотная характеристика
fchh = -np.arctan(omega * R * C)  # Фазо-частотная характеристика

# Сигнал
A = 3  # Амплитуда
omega_1 = 2.5  # Частота сигнала
t = np.linspace(0, 50, 1000)  # Время
s = A * np.cos(omega_1 * t)  # Исходный сигнал

# Найдем индекс частоты, ближайшей к omega_1
index_achh = np.searchsorted(omega, omega_1)  # Найдем индекс для omega_1 в массиве частот
index_fchh = np.searchsorted(omega, omega_1)

# Модифицированный сигнал после фильтрации
y = achh[index_achh] * A * np.cos(omega_1 * t + fchh[index_fchh])

# Построение графиков
plt.figure(figsize=(12, 8))

# График АЧХ
plt.subplot(2, 1, 1)
plt.plot(omega, achh, label="АЧХ")
plt.grid()
plt.legend()

# График ФЧХ
plt.subplot(2, 1, 2)
plt.plot(omega, fchh, label="ФЧХ")
plt.grid()
plt.legend()

plt.figure(figsize=(12, 8))

# График исходного и отфильтрованного сигналов
plt.subplot(3, 1, 1)
plt.plot(t, s, label='Исходный сигнал')
plt.plot(t, y, label='Отфильтрованный сигнал')
plt.grid()
plt.legend()

plt.subplot(3, 1, 2)
plt.plot(t, s, label='Исходный сигнал')
plt.plot(t, y * 0.3, label='Фильтрованный (0.3)')
plt.grid()
plt.legend()

plt.subplot(3, 1, 3)
plt.plot(t, s, label='Исходный сигнал')
plt.plot(t, y * 0.6, label='Фильтрованный (0.6)')
plt.grid()
plt.legend()

plt.show()
