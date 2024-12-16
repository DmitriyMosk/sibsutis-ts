import numpy as np
import matplotlib.pyplot as plt

T0 = 2  # Duration of the rectangular pulse
U = 3   # Amplitude of the signal

t = np.linspace(0, 10, 1000)

x_values = np.array([U if 0 <= ta <= T0 else 0 for ta in t])  # Signal x(t)
h_values = np.array([1 if 0 <= ta <= T0 else 0 for ta in t])  # Signal h(t)

def manual_convolution(x, h):
    len_x = len(x)
    len_h = len(h)

    conv_len = len_x + len_h - 1
    conv_result = np.zeros(conv_len)

    for n in range(conv_len):
        for k in range(len_x):
            if 0 <= n - k < len_h:
                conv_result[n] += x[k] * h[n - k]

    return conv_result

conv = manual_convolution(x_values, h_values) * (t[1] - t[0])  # Convolution of x(t) and h(t)

t_conv = np.linspace(t[0], t[-1] + t[-1], len(conv))  # Time for the convolved signal

plt.subplot(3, 1, 1)
plt.plot(t, x_values, label='x(t)', color='blue')
plt.xlabel('t')
plt.ylabel('x(t)')
plt.legend()
plt.grid()

plt.subplot(3, 1, 2)
plt.plot(t, h_values, label='h(t)', color='green')
plt.xlabel('t')
plt.ylabel('h(t)')
plt.legend()
plt.grid()

plt.subplot(3, 1, 3)
plt.plot(t_conv, conv, label='Convolution', color='red')
plt.xlabel('t')
plt.ylabel('Conv[x(t), h(t)]')
plt.legend()
plt.grid()

plt.show()