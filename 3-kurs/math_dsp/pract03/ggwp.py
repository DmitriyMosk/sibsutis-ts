import numpy as np
import matplotlib.pyplot as plt

# Параметры сигнала
T = 4  # Период сигнала
tau = 0.3  # Длительность прямоугольного импульса
A = 8  # Амплитуда сигнала
n_max = 10  # Количество гармоник для расчета


# Прямоугольный сигнал
def rectangular_signal(t, T, tau, A):
    t_mod = t % T  # Периодический сигнал
    return np.where(t_mod < tau, A, 0)


# Вычисление коэффициентов ряда Фурье
def compute_fourier_coefficients(T, tau, A, n_max):
    a_n = np.zeros(n_max + 1)
    b_n = np.zeros(n_max + 1)

    # a_0
    a_n[0] = (1 / T) * A * tau  # Поскольку это постоянная часть прямоугольного сигнала

    # Временные точки для численного интегрирования
    t_vals = np.linspace(0, T, 1000)

    # a_n и b_n для n = 1, 2, ..., n_max
    for n in range(1, n_max + 1):
        cos_term = np.cos(2 * np.pi * n * t_vals / T)
        sin_term = np.sin(2 * np.pi * n * t_vals / T)

        # Интегрируем только по участку, где сигнал не равен 0 (от 0 до tau)
        a_n[n] = (2 / T) * np.trapezoid(rectangular_signal(t_vals, T, tau, A) * cos_term, t_vals)
        b_n[n] = (2 / T) * np.trapezoid(rectangular_signal(t_vals, T, tau, A) * sin_term, t_vals)

    return a_n, b_n


# Вычисление амплитуд и фаз
def compute_amplitude_phase(a_n, b_n):
    A_n = np.sqrt(a_n ** 2 + b_n ** 2)
    phi_n = np.arctan2(b_n, a_n)  # atan2 для правильного определения угла
    return A_n, phi_n


# Построение графиков
def plot_fourier(A_n, phi_n, title_suffix=""):
    n_values = np.arange(len(A_n))
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))

    # График A_n
    ax1.stem(n_values, A_n, basefmt=" ")
    ax1.set_title(f'Амплитуды $A_n$ {title_suffix}')
    ax1.set_xlabel('n')
    ax1.set_ylabel('$A_n$')
    ax1.grid()

    # График φ_n
    ax2.stem(n_values, phi_n, basefmt=" ")
    ax2.set_title(r'Фазы $\phi_n$ ' + title_suffix)
    ax2.set_xlabel('n')
    ax2.set_ylabel(r'$\phi_n$ (радианы)')
    ax2.grid()

    plt.tight_layout()
    plt.show()


# Основная программа
a_n, b_n = compute_fourier_coefficients(T, tau, A, n_max)
A_n, phi_n = compute_amplitude_phase(a_n, b_n)

# Построение графиков для прямоугольного сигнала
plot_fourier(A_n, phi_n, title_suffix="для прямоугольного сигнала")