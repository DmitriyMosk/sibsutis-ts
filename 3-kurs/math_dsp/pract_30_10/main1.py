from cProfile import label

import numpy as np
import matplotlib.pyplot as plt

freq_samples = 400

t = np.linspace(0, 2/60, 4000)
t_n = np.arange(0, 2/60, 1/freq_samples)
t_2n = np.linspace(-10, 10, 251)
t_3n = np.linspace(-2/60, 2/60, 251)

phase_shift = 0

x1 = np.cos(2 * np.pi * 60 * t + phase_shift)
x2 = np.cos(2 * np.pi * 340 * t + phase_shift)
x3 = np.cos(2 * np.pi * 460 * t + phase_shift)

x1_tn = np.cos(2 * np.pi * 60 * t_n + phase_shift)
x2_tn = np.cos(2 * np.pi * 340 * t_n + phase_shift)
x3_tn = np.cos(2 * np.pi * 460 * t_n + phase_shift)

h = np.sin(np.pi*t_2n) / (np.pi*t_2n)

plt.figure(figsize=(16, 8))
plt.subplot(4,1,1)
plt.plot(t, x1, 'r')
plt.stem(t_n, x1_tn, 'b')
plt.subplot(4,1,2)
plt.plot(t, x2, 'r')
plt.stem(t_n, x2_tn, 'b')
plt.subplot(4,1,3)
plt.plot(t, x3, 'r')
plt.stem(t_n, x3_tn, 'b')
plt.subplot(4,1,4)
plt.plot(t_2n, h, 'r')
plt.show()

# свёртка h1 и xN(t)

recovery_x1 = np.convolve(x1, h, mode='same')

plt.figure(figsize=(12, 6))
plt.subplot(3, 1, 1)
plt.plot(t, recovery_x1)
plt.title("Recovery x1")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 2)
plt.plot(t, recovery_x2)
plt.title("Recovery x2")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 3)
plt.plot(t, recovery_x3)
plt.title("Recovery x3")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.grid(True)

plt.tight_layout()
plt.show()


