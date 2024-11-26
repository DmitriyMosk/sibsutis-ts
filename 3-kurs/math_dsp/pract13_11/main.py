from scipy.fftpack import fft, ifft, fftshift
import numpy as np
import matplotlib.pyplot as plt

fc = 10
fs = 32 * fc

t_line = np.arange(0, 2, 1 / fs)
x = np.cos(2 * np.pi * fc * t_line)

plt.figure(1)
plt.plot(t_line, x)
plt.xlabel('$t=nT_s$')
plt.ylabel('$x[n]$')
plt.show()

N = 256
X = fft(x, N) / N

plt.figure(2)
k = np.arange(0, N)
plt.stem(k,abs(X))
plt.xlabel('$k$')
plt.ylabel('$x[k]$')
plt.show()