import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy.signal import freqz
from scipy import fftpack

# Исходные параметры
f1 = 80  # Частота первого сигнала
f2 = 150  # Частота второго сигнала
Ts = 1e-3  # Шаг по времени
fs = 1 / Ts  # Частота дискретизации
t = np.arange(0, 100) * Ts  # Временной вектор
s = np.cos(f1 * t * (2 * np.pi)) + np.cos(f2 * t * (2 * np.pi))  # Сигнал

plt.figure(1)
sp = fftpack.fft(s)
freqs = np.arange(0, fs, fs / len(s))
plt.plot(freqs, np.abs(sp))
plt.title("Спектр исходного сигнала")
plt.xlabel('Частота [Hz]')
plt.ylabel('Модуль спектра')

fc = 140  # Частота среза
wc = fc * 2 * np.pi / fs  # Частота в радианах
M = 25  # Порядок фильтра
n = np.arange(-M, M + 1, dtype=float)  # Временной индекс фильтра

for i in range(0, len(n)): 
    if n[i] == 0: 
        n[i] = 0.0001
        
h = np.sin(wc * n) / (np.pi * n)
h[M] = wc / np.pi  # Учитываем случай n=0 вручную
plt.figure(2)
plt.stem(h)
plt.title("Импульсная характеристика фильтра")
plt.xlabel("Индекс n")
plt.ylabel("h(n)")

plt.figure(3)
w, hf = freqz(h, 1, fs=fs)
plt.plot(w, 20 * np.log10(np.abs(hf)))
plt.title("Частотная характеристика фильтра")
plt.xlabel("Частота [Hz]")
plt.ylabel("Амплитуда [dB]")

y = np.convolve(s, hf, mode='same')  # Применяем фильтр к сигналу
yf = fftpack.fft(y)

plt.figure(4)
freqs = np.arange(0, fs, fs / len(yf))
plt.plot(freqs, np.abs(yf))
plt.title("Спектр фильтрованного сигнала")
plt.xlabel('Частота [Hz]')
plt.ylabel('Модуль спектра')

plt.show()
