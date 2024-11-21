% 1 
lambda = 3; % Интенсивность потока заявок
mu = 4; % Интенсивность обслуживания заявок

% Проверка критерия Эрланга на стационарность
erlang_p = lambda/mu; 

if erlang_p < 1
    fprintf('Система стационарна, так как коэффициент загрузки rho = %.2f < 1\n', erlang_p);
else
    fprintf('Система нестационарна, коэффициент загрузки rho = %.2f >= 1\n', erlang_p);
end

E_input_thread = 1 / lambda; 
D_input_thread = 1 / lambda^2;

E_work_thread = 1 / mu; 
D_work_thread = 1 / mu^2; 

fprintf('Математическое ожидание для времени между заявками: %.4f\n', E_input_thread);
fprintf('Дисперсия для времени между заявками: %.4f\n', D_input_thread);
fprintf('Математическое ожидание для времени обслуживания: %.4f\n', E_work_thread);
fprintf('Дисперсия для времени обслуживания: %.4f\n', D_work_thread);

% 4 

Eexp = E_input_thread;
Dexp = D_input_thread; 

% Вывел для гамма
b_param = 1/lambda;
c_param = 1;

N_len = 200;

% M/M/1
tau_n = exprnd(b_param, [1, N_len]);
nu_n = exprnd(c_param, [1, N_len]);  

% G/G/1
tau_1n = gamrnd(c_param, b_param, [1, N_len]); 
nu_1n = gamrnd(c_param, b_param, [1, N_len]);

% 1. Расчет статистических характеристик для M/M/1
mean_tau_n = mean(tau_n); 
var_tau_n = var(tau_n); 

mean_nu_n = mean(nu_n); 
var_nu_n = var(nu_n);

% 2. Расчет статистических характеристик для G/G/1
mean_tau_1n = mean(tau_1n);
var_tau_1n = var(tau_1n);

mean_nu_1n = mean(nu_1n);
var_nu_1n = var(nu_1n);

% Построение графиков
figure;

% График средних значений
subplot(2, 3, 1);
bar([mean_tau_n, mean_nu_n; mean_tau_1n, mean_nu_1n]);
set(gca, 'XTickLabel', {'M/M/1', 'G/G/1'});
title('Средние значения \tau и \nu');
legend({'\tau', '\nu'});
xlabel('Модель');
ylabel('Среднее значение');

% График дисперсий
subplot(2, 3, 2);
bar([var_tau_n, var_nu_n; var_tau_1n, var_nu_1n]);
set(gca, 'XTickLabel', {'M/M/1', 'G/G/1'});
title('Дисперсии \tau и \nu');
legend({'\tau', '\nu'});
xlabel('Модель');
ylabel('Дисперсия');

% Гистограммы распределений

% Гистограмма M/M/1 - \tau_n
subplot(2, 3, 3);
histogram(tau_n, 20);
hold on;
xline(mean_tau_n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \tau для M/M/1');
xlabel('\tau');
ylabel('Частота');
legend('Распределение', ['Среднее \tau = ' num2str(mean_tau_n)]);

% Гистограмма M/M/1 - \nu_n
subplot(2, 3, 4);
histogram(nu_n, 20);
hold on;
xline(mean_nu_n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \nu для M/M/1');
xlabel('\nu');
ylabel('Частота');
legend('Распределение', ['Среднее \nu = ' num2str(mean_nu_n)]);

% Гистограмма G/G/1 - \tau_1n
subplot(2, 3, 5);
histogram(tau_1n, 20);
hold on;
xline(mean_tau_1n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \tau для G/G/1');
xlabel('\tau');
ylabel('Частота');
legend('Распределение', ['Среднее \tau = ' num2str(mean_tau_1n)]);

% Гистограмма G/G/1 - \nu_1n
subplot(2, 3, 6);
histogram(nu_1n, 20);
hold on;
xline(mean_nu_1n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \nu для G/G/1');
xlabel('\nu');
ylabel('Частота');
legend('Распределение', ['Среднее \nu = ' num2str(mean_nu_1n)]);

% Вывод результатов
fprintf('Статистические характеристики для системы M/M/1:\n');
fprintf('Среднее tau_n: %.4f, Дисперсия tau_n: %.4f\n', mean_tau_n, var_tau_n);
fprintf('Среднее nu_n: %.4f, Дисперсия nu_n: %.4f\n', mean_nu_n, var_nu_n);

fprintf('Статистические характеристики для системы G/G/1:\n');
fprintf('Среднее tau_1n: %.4f, Дисперсия tau_1n: %.4f\n', mean_tau_1n, var_tau_1n);
fprintf('Среднее nu_1n: %.4f, Дисперсия nu_1n: %.4f\n', mean_nu_1n, var_nu_1n);

% Сравнение аналитических и статистических характеристик для M/M/1
fprintf('Аналитическое среднее tau: %.4f, Статистическое среднее tau_n: %.4f\n', E_input_thread, mean_tau_n);
fprintf('Аналитическая дисперсия tau: %.4f, Статистическая дисперсия tau_n: %.4f\n', D_input_thread, var_tau_n);

fprintf('Аналитическое среднее nu: %.4f, Статистическое среднее nu_n: %.4f\n', E_work_thread, mean_nu_n);
fprintf('Аналитическая дисперсия nu: %.4f, Статистическая дисперсия nu_n: %.4f\n', D_work_thread, var_nu_n);

% Сравнение статистических характеристик M/M/1 и G/G/1
fprintf('Сравнение статистических характеристик tau_n и tau_1n:\n');
fprintf('Среднее tau_n: %.4f, Среднее tau_1n: %.4f\n', mean_tau_n, mean_tau_1n);
fprintf('Дисперсия tau_n: %.4f, Дисперсия tau_1n: %.4f\n', var_tau_n, var_tau_1n);

fprintf('Сравнение статистических характеристик nu_n и nu_1n:\n');
fprintf('Среднее nu_n: %.4f, Среднее nu_1n: %.4f\n', mean_nu_n, mean_nu_1n);
fprintf('Дисперсия nu_n: %.4f, Дисперсия nu_1n: %.4f\n\n\n\n', var_nu_n, var_nu_1n);

N_len = 10000;  % Увеличим N для более точных значений
% Повторим генерацию последовательностей и расчеты статистики

% M/M/1
tau_n = exprnd(1/lambda, [1, N_len]);
nu_n = exprnd(1/mu, [1, N_len]);

% G/G/1
tau_1n = gamrnd(c_param, b_param, [1, N_len]);
nu_1n = gamrnd(c_param, b_param, [1, N_len]);

% Пересчитаем средние и дисперсии и выведем результат
% (Можно повторить все шаги, аналогично вышеуказанным)

% 1. Расчет статистических характеристик для M/M/1
mean_tau_n = mean(tau_n); 
var_tau_n = var(tau_n); 

mean_nu_n = mean(nu_n); 
var_nu_n = var(nu_n);

% 2. Расчет статистических характеристик для G/G/1
mean_tau_1n = mean(tau_1n);
var_tau_1n = var(tau_1n);

mean_nu_1n = mean(nu_1n);
var_nu_1n = var(nu_1n);

% Вывод результатов
fprintf('Статистические характеристики для системы M/M/1:\n');
fprintf('Среднее tau_n: %.4f, Дисперсия tau_n: %.4f\n', mean_tau_n, var_tau_n);
fprintf('Среднее nu_n: %.4f, Дисперсия nu_n: %.4f\n', mean_nu_n, var_nu_n);

fprintf('Статистические характеристики для системы G/G/1:\n');
fprintf('Среднее tau_1n: %.4f, Дисперсия tau_1n: %.4f\n', mean_tau_1n, var_tau_1n);
fprintf('Среднее nu_1n: %.4f, Дисперсия nu_1n: %.4f\n', mean_nu_1n, var_nu_1n);

% Сравнение аналитических и статистических характеристик для M/M/1
fprintf('Аналитическое среднее tau: %.4f, Статистическое среднее tau_n: %.4f\n', E_input_thread, mean_tau_n);
fprintf('Аналитическая дисперсия tau: %.4f, Статистическая дисперсия tau_n: %.4f\n', D_input_thread, var_tau_n);

fprintf('Аналитическое среднее nu: %.4f, Статистическое среднее nu_n: %.4f\n', E_work_thread, mean_nu_n);
fprintf('Аналитическая дисперсия nu: %.4f, Статистическая дисперсия nu_n: %.4f\n', D_work_thread, var_nu_n);

% Сравнение статистических характеристик M/M/1 и G/G/1
fprintf('Сравнение статистических характеристик tau_n и tau_1n:\n');
fprintf('Среднее tau_n: %.4f, Среднее tau_1n: %.4f\n', mean_tau_n, mean_tau_1n);
fprintf('Дисперсия tau_n: %.4f, Дисперсия tau_1n: %.4f\n', var_tau_n, var_tau_1n);

fprintf('Сравнение статистических характеристик nu_n и nu_1n:\n');
fprintf('Среднее nu_n: %.4f, Среднее nu_1n: %.4f\n', mean_nu_n, mean_nu_1n);
fprintf('Дисперсия nu_n: %.4f, Дисперсия nu_1n: %.4f\n\n\n\n\n\n', var_nu_n, var_nu_1n);

% Построение графиков
figure;

% График средних значений
subplot(2, 3, 1);
bar([mean_tau_n, mean_nu_n; mean_tau_1n, mean_nu_1n]);
set(gca, 'XTickLabel', {'M/M/1', 'G/G/1'});
title('Средние значения \tau и \nu');
legend({'\tau', '\nu'});
xlabel('Модель');
ylabel('Среднее значение');

% График дисперсий
subplot(2, 3, 2);
bar([var_tau_n, var_nu_n; var_tau_1n, var_nu_1n]);
set(gca, 'XTickLabel', {'M/M/1', 'G/G/1'});
title('Дисперсии \tau и \nu');
legend({'\tau', '\nu'});
xlabel('Модель');
ylabel('Дисперсия');

% Гистограммы распределений

% Гистограмма M/M/1 - \tau_n
subplot(2, 3, 3);
histogram(tau_n, 20);
hold on;
xline(mean_tau_n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \tau для M/M/1');
xlabel('\tau');
ylabel('Частота');
legend('Распределение', ['Среднее \tau = ' num2str(mean_tau_n)]);

% Гистограмма M/M/1 - \nu_n
subplot(2, 3, 4);
histogram(nu_n, 20);
hold on;
xline(mean_nu_n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \nu для M/M/1');
xlabel('\nu');
ylabel('Частота');
legend('Распределение', ['Среднее \nu = ' num2str(mean_nu_n)]);

% Гистограмма G/G/1 - \tau_1n
subplot(2, 3, 5);
histogram(tau_1n, 20);
hold on;
xline(mean_tau_1n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \tau для G/G/1');
xlabel('\tau');
ylabel('Частота');
legend('Распределение', ['Среднее \tau = ' num2str(mean_tau_1n)]);

% Гистограмма G/G/1 - \nu_1n
subplot(2, 3, 6);
histogram(nu_1n, 20);
hold on;
xline(mean_nu_1n, 'r', 'LineWidth', 2); % Среднее значение
hold off;
title('Распределение \nu для G/G/1');
xlabel('\nu');
ylabel('Частота');
legend('Распределение', ['Среднее \nu = ' num2str(mean_nu_1n)]);

time_limit = 1000; % Предел времени для моделирования

% M/M/1
tau_mm1 = exprnd(1/lambda, [1, N_len]); 
nu_mm1 = exprnd(1/mu, [1, N_len]);     

% M/G/1 (экспоненциальное распределение для межприхода, гамма для обслуживания)
tau_mg1 = tau_mm1;
nu_mg1 = gamrnd(2, 1/mu, [1, N_len]);

% G/M/1 (гамма для межприхода, экспоненциальное для обслуживания)
tau_gm1 = gamrnd(2, 1/lambda, [1, N_len]);
nu_gm1 = nu_mm1;

% G/G/1 (гамма для межприхода и обслуживания)
tau_gg1 = gamrnd(2, 1/lambda, [1, N_len]);
nu_gg1 = gamrnd(2, 1/mu, [1, N_len]);

% 2. Моделирование для каждого типа СМО
[time_mm1, queue_mm1] = simulate_queue(tau_mm1, nu_mm1, time_limit);
[time_mg1, queue_mg1] = simulate_queue(tau_mg1, nu_mg1, time_limit);
[time_gm1, queue_gm1] = simulate_queue(tau_gm1, nu_gm1, time_limit);
[time_gg1, queue_gg1] = simulate_queue(tau_gg1, nu_gg1, time_limit);

% 3. Построение графиков зависимости числа заявок от времени

figure;
subplot(2,2,1);
plot(1:N_len, queue_mm1);
title('M/M/1: Количество заявок в системе');

subplot(2,2,2);
plot(1:N_len, queue_mg1);
title('M/G/1: Количество заявок в системе');

subplot(2,2,3);
plot(1:N_len, queue_gm1);
title('G/M/1: Количество заявок в системе');

subplot(2,2,4);
plot(1:N_len, queue_gg1);
title('G/G/1: Количество заявок в системе');

% 4. Рассчёт коэффициента загрузки, среднего числа заявок и времени пребывания

% M/M/1
[L_mm1, W_mm1] = calculate_stats(tau_mm1, nu_mm1);

% M/G/1
[L_mg1, W_mg1] = calculate_stats(tau_mg1, nu_mg1);

% G/M/1
[L_gm1, W_gm1] = calculate_stats(tau_gm1, nu_gm1);

% G/G/1
[L_gg1, W_gg1] = calculate_stats(tau_gg1, nu_gg1);

% 5. Вывод статистических характеристик
fprintf("Global: Коэффициент нагрузки: %.4f\n", erlang_p);
fprintf('M/M/1: Среднее число заявок в системе L = %.4f, Среднее время пребывания W = %.4f\n', L_mm1, W_mm1);
fprintf('M/G/1: Среднее число заявок в системе L = %.4f, Среднее время пребывания W = %.4f\n', L_mg1, W_mg1);
fprintf('G/M/1: Среднее число заявок в системе L = %.4f, Среднее время пребывания W = %.4f\n', L_gm1, W_gm1);
fprintf('G/G/1: Среднее число заявок в системе L = %.4f, Среднее время пребывания W = %.4f\n', L_gg1, W_gg1);

rho = lambda / mu; % коэффициент загрузки

% Вариации для C_b^2 (нормированная дисперсия для M/G/1)
Cb2_values = [0, 1, 10, 20, 30, 100, 1000, 10000];
mean_service_time = 1 / mu;

% Выделение памяти для хранения результатов
Nq_MG1 = zeros(length(Cb2_values), 1);
N_MG1 = zeros(length(Cb2_values), 1);
Wq_MG1 = zeros(length(Cb2_values), 1);
T_MG1 = zeros(length(Cb2_values), 1);

mu_mg1 = mu * 0.8; % чуть ниже для M/G/1
mu_md1 = mu * 1.2; % чуть выше для M/D/1
mu_mm1 = mu; % оставляем стандартным для M/M/1

% Рассчёт характеристик для M/G/1 с измененным mu
for i = 1:length(Cb2_values)
    Cb2 = Cb2_values(i);
    Nq_MG1(i) = (rho^2 * (1 + Cb2)) / (2 * (1 - rho)); % Среднее число заявок в очереди
    N_MG1(i) = Nq_MG1(i) + rho; % Среднее число заявок в системе
    Wq_MG1(i) = Nq_MG1(i) / lambda; % Среднее время ожидания
    T_MG1(i) = Wq_MG1(i) + (1 / mu_mg1); % Среднее время пребывания с измененным mu
end

% Рассчёт характеристик для M/D/1 с измененным mu
Nq_MD1 = (rho^2) / (2 * (1 - rho)); % Среднее число заявок в очереди
N_MD1 = Nq_MD1 + rho; % Среднее число заявок в системе
Wq_MD1 = Nq_MD1 / lambda; % Среднее время ожидания
T_MD1 = Wq_MD1 + (1 / mu_md1); % Среднее время пребывания с измененным mu

% Характеристики для M/M/1
Nq_MM1 = rho^2 / (1 - rho); % Среднее число заявок в очереди
N_MM1 = rho / (1 - rho); % Среднее число заявок в системе
Wq_MM1 = Nq_MM1 / lambda; % Среднее время ожидания
T_MM1 = 1 / (mu * (1 - rho)); % Среднее время пребывания

% Графики
figure;
subplot(2,2,1);
plot(Cb2_values, Nq_MG1, 'b-', 'LineWidth', 2); hold on;
plot(Cb2_values, Nq_MD1*ones(size(Cb2_values)), 'r--', 'LineWidth', 2);
plot(Cb2_values, Nq_MM1*ones(size(Cb2_values)), 'g:', 'LineWidth', 2);
title('Среднее число заявок в очереди N_q');
xlabel('C_b^2');
ylabel('N_q');
legend('M/G/1', 'M/D/1', 'M/M/1');

subplot(2,2,2);
plot(Cb2_values, N_MG1, 'b-', 'LineWidth', 2); hold on;
plot(Cb2_values, N_MD1*ones(size(Cb2_values)), 'r--', 'LineWidth', 2);
plot(Cb2_values, N_MM1*ones(size(Cb2_values)), 'g:', 'LineWidth', 2);
title('Среднее число заявок в системе N');
xlabel('C_b^2');
ylabel('N');
legend('M/G/1', 'M/D/1', 'M/M/1');

subplot(2,2,3);
plot(Cb2_values, Wq_MG1, 'b-', 'LineWidth', 2); hold on;
plot(Cb2_values, Wq_MD1*ones(size(Cb2_values)), 'r--', 'LineWidth', 2);
plot(Cb2_values, Wq_MM1*ones(size(Cb2_values)), 'g:', 'LineWidth', 2);
title('Среднее время ожидания W_q');
xlabel('C_b^2');
ylabel('W_q');
legend('M/G/1', 'M/D/1', 'M/M/1');

subplot(2,2,4);
plot(Cb2_values, T_MG1, 'b-', 'LineWidth', 2); hold on;
plot(Cb2_values, T_MD1*ones(size(Cb2_values)), 'r--', 'LineWidth', 2);
plot(Cb2_values, T_MM1*ones(size(Cb2_values)), 'g:', 'LineWidth', 2);
title('Среднее время пребывания T');
xlabel('C_b^2');
ylabel('T');
legend('M/G/1', 'M/D/1', 'M/M/1');
