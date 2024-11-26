import numpy as np
import matplotlib.pyplot as plt

def convert_degree_to_radians(degrees) -> float:
    return degrees * np.pi / 180

class Sin:
    sub_plot_rows = 0
    sub_plot_cols = 0

    t = np.linspace(0, 1, 1000)

    @staticmethod
    def sub_plot(rows, cols):
        Sin.sub_plot_rows = rows
        Sin.sub_plot_cols = cols

    def __init__(self, ampl=1.0, freq=1.0, phase=1.0, use_cos=False):
        self.ampl = ampl
        self.freq = freq
        self.phase = phase
        self.use_cos = use_cos
        self.obj_plot = plt

    def __add__(self, *others):
        def combined_x(t):
            total = self.x(t)
            for other in others:
                total += other.x(t)
            return total

        new_sin = Sin()
        new_sin.x = combined_x

        return new_sin

    def x(self, t):
        if not self.use_cos:
            return self.ampl * np.sin(2 * np.pi * self.freq * t + self.phase)
        else:
            return self.ampl * np.cos(2 * np.pi * self.freq * t + self.phase)

    def plot(self, color="blue", custom_text=None, show_lable=True, linestyle=None, linewidth=None):
        if show_lable:
            if custom_text is None:
                plt.plot(Sin.t, self.x(Sin.t), color=color, label=f'A={self.ampl:.2f}, f={self.freq:.2f}, Phi={self.phase:.2f}', linestyle=linestyle, linewidth=linewidth)
                plt.legend(loc="lower right")
            else:
                plt.plot(Sin.t, self.x(Sin.t), color=color,
                         label=custom_text, linestyle=linestyle,
                         linewidth=linewidth)
                plt.legend(loc="lower right")
        else:
            if custom_text is None:
                plt.title(f'A={self.ampl:.2f}, f={self.freq:.2f}, Phi={self.phase:.2f}')
                plt.plot(Sin.t, self.x(Sin.t), color=color)
            else:
                plt.title(custom_text)
                plt.plot(Sin.t, self.x(Sin.t), color=color, linestyle=linestyle,
                          linewidth=linewidth)

        plt.xlabel('Time')
        plt.ylabel('Amplitude')

        plt.grid(True)
        return self

    def show_plot(self):
        self.obj_plot.tight_layout()
        self.obj_plot.show()

work_number = int(input("Какое задание показать?"))

if work_number == 1:
    # Демонстрация графиков с разными параметрами (1)
    sin_1 = Sin(2, 2, 2)
    sin_2 = Sin(3, 3, 3)
    sin_3 = Sin(6, 6, 6)

    plt.title("Моделирование гарм. колебаний с разными параметрами")
    plt.xlabel('Time (t)')
    plt.ylabel('Amplitude (A)')

    sin_1.plot('black')
    sin_2.plot('blue')
    sin_3.plot('green')

    plt.tight_layout()
    plt.legend()
    plt.grid(True)
    plt.show()

if work_number == 2:
    # Моделирование гарм. колебаний с разными фазами (2)
    sin_1 = Sin(ampl=1, freq=5, phase=convert_degree_to_radians(0))
    sin_2 = Sin(ampl=1, freq=5, phase=convert_degree_to_radians(90))
    sin_3 = Sin(ampl=1, freq=5, phase=convert_degree_to_radians(180))
    sin_4 = Sin(ampl=1, freq=5, phase=convert_degree_to_radians(270))

    plt.subplot(2, 2, 1)
    sin_1.plot(show_lable=False)

    plt.subplot(2, 2, 2)
    sin_2.plot(show_lable=False)

    plt.subplot(2, 2, 3)
    sin_3.plot(show_lable=False)

    plt.subplot(2, 2, 4)
    sin_4.plot(show_lable=False)

    plt.subplots_adjust(hspace=0.5, wspace=0.5)
    plt.show()

if work_number == 3:
    # Сложение гармонических колебаний колебания c различными фазами (3)
    sin_1 = Sin(ampl=1, freq=3, phase=convert_degree_to_radians(10))
    sin_2 = Sin(ampl=1, freq=3, phase=convert_degree_to_radians(43))
    sin_3 = Sin(ampl=1, freq=3, phase=convert_degree_to_radians(67))

    sin_sum = sin_1 + sin_2 + sin_3

    plt.title("Суммирование с различными фазами")
    plt.xlabel('Time (t)')
    plt.ylabel('Amplitude (A)')

    sin_1.plot(color='black', linestyle='--')
    sin_2.plot(color='blue', linestyle='--')
    sin_3.plot(color='green', linestyle="--")

    sin_sum.plot(color="red", custom_text="Result summ x(t)")

    plt.grid(True)
    plt.show()

if work_number == 4:
    # Выполните сложение колебаний и получите график колебания
    cos_1 = Sin(4/np.pi, 3, -np.pi/2, True)
    cos_2 = Sin(4/(np.pi*3), 3 * 3, -np.pi/2, True)

    cos_sum = cos_1 + cos_2

    plt.title("Сложение произвольных колебаний")
    plt.xlabel('Time (t)')
    plt.ylabel('Amplitude (A)')

    cos_1.plot(color='black', linestyle='--')
    cos_2.plot(color='blue', linestyle='--')

    cos_sum.plot(color="red", custom_text="Result summ x(t)")

    plt.grid(True)
    plt.show()

if work_number == 5:
    Sin.t = np.linspace(0, 3, 1000)

    cos_sum = Sin(use_cos=True)

    plt.title("Сложение произвольных колебаний")
    plt.xlabel('Time (t)')
    plt.ylabel('Amplitude (A)')

    colors = ['black', 'green', 'red',  'blue', 'grey', 'pink']

    for i in range(0, 5 + 1):
        cur_cos = Sin(4/((2*i-1)*np.pi),(2*i-1), -np.pi/2, use_cos=True)

        cur_cos.plot(color=colors[i], linestyle='--')

        cos_sum += cur_cos
        if i != 5:
            cos_sum.plot(color='black', linestyle='-.', linewidth=0.2, custom_text=f"Result summ x(t) step {i}")

    cos_sum.plot(custom_text="Result x(t)", color='black')
    plt.grid(True)
    plt.show()
