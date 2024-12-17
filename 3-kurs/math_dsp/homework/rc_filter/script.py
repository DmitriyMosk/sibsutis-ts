import matplotlib.pyplot as plt
import numpy as np

# Resistor & Capacitor

R = 10**(5)
C = 10**(-6)
 
# Почему 2 * 2 ?  
omega = np.linspace(0, (2 * 2 * np.pi) / (R * C), 100) 

def getFR(R, C): # FR - frequency response (АЧХ) 
    return 1 / np.sqrt(1 + (omega * R * C) ** 2)

def getPR(R, C): # PR - phase response (ФЧХ)
    return -1 * np.arctan(omega * R * C) 

 


