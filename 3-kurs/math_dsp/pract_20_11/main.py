import numpy as np
import matplotlib.pyplot as plt 
from scipy import signal
from scipy.signal import kaiserord, lfilter, firwin, freqz
from scipy import fftpack

Ts = 1e-3
fs = 1/Ts 

t_discrete = np.arange(0, 100) * Ts; 

f1 = 100
f2 = 180 

signal = np.cos( f1 * t_discrete * 2 * np.pi ) + np.cos(f2 * t_discrete * 2 * np.pi )  


