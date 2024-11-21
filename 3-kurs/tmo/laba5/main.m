% Количество узлов
L = 4; 
% Матрица переходов из 3-ей лабы 
P = [
        0.8, 0.1, 0.1, 0; 
        0.2, 0.7, 0.1, 0; 
        0.1, 0.2, 0.5, 0.2; 
        0.2 0.2 0.2 0.4
    ];

N = L^2; 
s = 1; 

trajectory = MarkovTrajectory(P,N,s);

figure;
    plot(1:N, trajectory, '-o', 'LineWidth', 2);
    title('Траектория движения пакета по сети');
    xlabel('Шаг');
    ylabel('Состояние (узел)');
    grid on;

    yticks(1:size(P, 1));

epsilon = 1e-3;

% Вычисления
m = N;  % Количество шагов
probs = zeros(L, L);
shortest_paths = zeros(L, L);
expected_lengths = zeros(L, L);
variances = zeros(L, L);
probs_prebi = 0; 

for i = 1:L
    for j = 1:L
        probs(i, j) = first_passage_probability(P, i, j, m);
        shortest_paths(i, j) = shortest_path_length(P, i, j);
        expected_lengths(i, j) = expected_path_length(P, i, j, epsilon);
        variances(i, j) = variance_path_length(P, i, j, epsilon);
        probs_prebi = P.^i;
    end
end

i = 1; j = 3;  % Начальное и конечное состояния
disp(['Вероятность первого перехода: ', num2str(first_passage_probability(P, i, j, N))]);
disp(['Длина кратчайшего пути: ', num2str(shortest_path_length(P, i, j))]);
disp(['Математическое ожидание длины пути: ', num2str(expected_path_length(P, i, j, epsilon))]);
disp(['Дисперсия длины пути: ', num2str(variance_path_length(P, i, j, epsilon))]);
disp(['Вероятность пребывания пакета: ', num2str(probs_prebi(i,j))]);

% Вероятности первого перехода пакета
figure;
plot(probs);
title('Вероятности первого перехода пакета');
xlabel('Узлы');
ylabel('Вероятность');
grid on;

% Создаем матрицу кратчайших путей (у вас уже есть это как shortest_paths)
n = size(shortest_paths, 1);
pairs = cell(n * n, 1);  % массив для пар узлов
index = 1;

% Формируем метки вида (i,j)
for i = 1:n
    for j = 1:n
        pairs{index} = sprintf('(%d,%d)', i, j);
        index = index + 1;
    end
end

% Построение графика
figure;
bar(shortest_paths(:));  % столбчатая диаграмма
title('Длины кратчайших путей');
xlabel('Пары узлов');
ylabel('Длина пути');
set(gca, 'XTick', 1:(n*n), 'XTickLabel', pairs);  % установка меток оси X
xtickangle(45);  % поворот меток оси X для удобства чтения
grid on;

% Математические ожидания длин путей
figure;
plot(expected_lengths);
title('Математические ожидания длин путей');
xlabel('Узлы');
ylabel('Математическое ожидание длины пути');
grid on;

% Дисперсии длин путей
figure;
plot(variances);
title('Дисперсии длин путей');
xlabel('Узлы');
ylabel('Дисперсия длины пути');
grid on;

% Дисперсии длин путей
figure;
plot(probs_prebi);
title('вероятность пребывания пакета в узле j после m коммутаций при условии, что пакет поступил в сеть через узел j');
xlabel('Узлы');
ylabel('Дисперсия длины пути');
grid on;






