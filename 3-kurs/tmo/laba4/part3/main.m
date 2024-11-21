% Задание размерности матрицы переходов
L = 4;
T = zeros(L, L);  % Обнуление всех элементов матрицы

P = [0, 3, 3, 3;
     3, 0, 2, 1;
     3, 2, 0, 1;
     3, 2, 1, 0];

T(1:4, 1:4) = P;

% Убедимся, что все строки суммируются до 1 (стоимость каждого перехода)
for i = 1:L
    if sum(T(i, :)) == 0  % Если строка пустая, добавляем равномерные вероятности
        possible_destinations = setdiff(1:L, i);
        chosen_destinations = possible_destinations(randperm(numel(possible_destinations), 3));
        T(i, chosen_destinations) = 1/3;
    end
    T(i, :) = T(i, :) / sum(T(i, :));  % Нормализация строки
end

% Проверка стохастичности
is_stochastic = stochastic(T);
disp(['Матрица стохастическая: ', num2str(is_stochastic)]);

% Проверка эргодичности
is_ergodic = ergodic(T);
disp(['Цепь Маркова эргодическая: ', num2str(is_ergodic)]);

function res = stochastic(matrix)
    [rows, cols] = size(matrix);
    res = true;
    for i = 1:rows
        if abs(sum(matrix(i, :)) - 1) > eps
            res = false;
            break;
        end
    end
end

function res = ergodic(matrix)
    res = all(eig(matrix) > 0);
end



