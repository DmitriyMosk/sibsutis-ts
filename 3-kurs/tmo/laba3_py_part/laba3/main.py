import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

# Матрица переходов цепи Маркова
P = np.array([[0.8, 0.1, 0.1, 0],
              [0.2, 0.7, 0.1, 0],
              [0.1, 0.2, 0.5, 0.2],
              [0.2, 0.2, 0.2, 0.4]])

# Список состояний
states = ['S1', 'S2', 'S3', 'S4']

# Создание направленного графа (DiGraph) с помощью NetworkX
G = nx.DiGraph()

# Добавляем рёбра в граф с вероятностями переходов
for i, state_from in enumerate(states):
    for j, state_to in enumerate(states):
        if P[i, j] > 0:
            G.add_edge(state_from, state_to, weight=P[i, j])

# Позиции для узлов
pos = nx.spring_layout(G)

# Визуализация графа
plt.figure(figsize=(8, 6))
nx.draw(G, pos, with_labels=True, node_size=2000, node_color='lightblue', font_size=12, font_weight='bold')
edge_labels = {(state_from, state_to): f'{P[i, j]:.1f}'
               for i, state_from in enumerate(states)
               for j, state_to in enumerate(states) if P[i, j] > 0}
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels, font_size=10)

# Добавляем заголовок
plt.title("Марковская цепь")

# Показываем граф
plt.show()