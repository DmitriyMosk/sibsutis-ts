import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import sawtooth

# Параметры
Fs = 1000  # Частота дискретизации (Гц)
T = 1  # Продолжительность сигнала (сек)
f0 = 50  # Частота пилообразного сигнала (Гц)

# Время
t = np.linspace(0, T, Fs, endpoint=False)

# Генерация пилообразного сигнала
signal = sawtooth(2 * np.pi * f0 * t)

# Вычисление FFT сигнала
X_f = np.fft.fft(signal)

# Частотная ось
frequencies = np.fft.fftfreq(len(t), 1/Fs)

# Применение фильтра Гилберта в частотной области
X_f_filtered = X_f.copy()
X_f_filtered[frequencies > 0] *= 1j  # Для положительных частот умножаем на j
X_f_filtered[frequencies < 0] *= -1j  # Для отрицательных частот умножаем на -j

# Манипуляция частотой: сдвиг спектра (например, на 50 Гц)
frequency_shift = 500
X_f_shifted = np.roll(X_f_filtered, int(frequency_shift * len(t) / Fs))

# Обратное FFT для получения аналитического сигнала
analytic_signal = np.fft.ifft(X_f_filtered)

# Обратное FFT для сдвинутого спектра
analytic_signal_shifted = np.fft.ifft(X_f_shifted)

# Визуализация результатов
plt.figure(figsize=(12, 8))

# Оригинальный сигнал
plt.subplot(3, 1, 1)
plt.plot(t, signal)
plt.title("Оригинальный пилообразный сигнал")
plt.xlabel("Время [с]")
plt.ylabel("Амплитуда")

# Аналитический сигнал после применения фильтра Гилберта
plt.subplot(3, 1, 2)
plt.plot(t, np.abs(analytic_signal))
plt.title("Аналитический сигнал (модуль) после фильтра Гилберта")
plt.xlabel("Время [с]")
plt.ylabel("Амплитуда")

# Аналитический сигнал после сдвига частоты
plt.subplot(3, 1, 3)
plt.plot(t, np.abs(analytic_signal_shifted))
plt.title("Аналитический сигнал после сдвига частоты")
plt.xlabel("Время [с]")
plt.ylabel("Амплитуда")

plt.tight_layout()
plt.show()
