import matplotlib.pyplot as plt 
import numpy as np
from scipy.fftpack import fft, ifft

M = 14
K = np.arange(0,M-1,1)
print(K)

h_a = np.array([1,1,1,1,0,0,0,0,0,0,0,0,0])
h_p = np.exp((- 1j * K * (np.pi * 2 / M) * (M - 1)/2))

print(h_p)

plt.figure("ha")
plt.plot(h_a)

plt.figure("hp")
plt.subplot(2,1,1)
plt.plot(np.real(h_p))
plt.subplot(2,1,2)
plt.plot(np.imag(h_p))

H = h_p * h_a
plt.figure("ha * hp")
plt.plot(H)

H_2 = np.conjugate(H)
# H_2_R = H_2[::-1]
H_2 = H_2[::-1]
sum_H = np.concatenate((H, H_2), axis = 0)

plt.figure('Conj') 
plt.subplot(4,1,1) 
plt.plot(np.real(H_2))
plt.subplot(4,1,2) 
plt.plot(np.imag(H_2)) 
# plt.subplot(4,1,3) 
# plt.plot(np.real(H_2_R))
# plt.subplot(4,1,4) 
# plt.plot(np.imag(H_2_R))

print(sum_H)

plt.figure("sum_H")
plt.plot(np.abs(sum_H))

plt.figure("arg sum_h") 
plt.plot(np.angle(sum_H)) 

ht = np.real(ifft(sum_H))

plt.figure("ht")
plt.plot(ht)

plt.show()

