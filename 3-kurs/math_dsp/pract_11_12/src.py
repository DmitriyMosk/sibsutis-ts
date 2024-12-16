import numpy as np 
import matplotlib.pyplot as plt 

def HPF(np_samples): 
    print(np_samples)
    return np_samples

def Decimation(np_samples):  
    print(np_samples)


fs = 8 * 10 ** 3
Ts = 1 / fs 

t_l = np.arange(0, 100, Ts) 

S_t = 5 * np.cos(2 * np.pi * 1000 * t_l) + np.sin(2 * np.pi * 2500 * t_l) 

plt.figure(1)
plt.plot(t_l, S_t)
plt.show()

fpass = 1.3 * 10 ** 3
fstop = 2 * 10 ** 3 
f_c = (fpass + fstop) / 2

# weight window
S_t = HPF(S_t) 

plt.figure(2)
plt.plot(t_l, S_t)
plt.show()

# decimation (сделать интерполяцию с 8Khz до 24 M = 3 up)
S_t = Decimation(S_t) 

plt.figure(3)
plt.plot(t_l, S_t)
plt.show()

f_order = 3.3 * fs / (fstop - fpass)

fft_sig = np.fft.fft(S_t)
fft_freq = np.fft.fftfreq(len(S_t), Ts)  