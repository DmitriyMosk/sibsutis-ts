% Плотность распределения
f = @(x) 0.25; 
a = 0; 
b = 4;

% Функция распределения
F = @(x) integral(f, a, x, 'ArrayValued', true);
F_inv = @(x) a + (b-a)*F(x); 

% Начало генерации выборки
Arr_50 = rand(50, 1);
Arr_200 = rand(200, 1);
Arr_1000 = rand(1000, 1);

for i=1:length(Arr_50) 
    Arr_50(i) = F_inv(Arr_50(i));
end 

for i=1:length(Arr_200) 
    Arr_200(i) = F_inv(Arr_200(i));
end 

for i=1:length(Arr_1000) 
    Arr_1000(i) = F_inv(Arr_1000(i));
end 
% Конец генерации выборки 

% точечные оценки среднего, дисперсии и среднеквадратического отклонения (СКО)
% точечная оценка среднего (математичекое ожидание) 
Arr_50_Mean = mean(Arr_50); 
% точечная оценка дисперсии
Arr_50_Disp = var(Arr_50);
% СКО
Arr_50_Std = std(Arr_50); 
% точечная оценка среднего (математичекое ожидание) 
Arr_200_Mean = mean(Arr_200); 
% точечная оценка дисперсии
Arr_200_Disp = var(Arr_200);
% СКО
Arr_200_Std = std(Arr_200); 
% точечная оценка среднего (математичекое ожидание) 
Arr_1000_Mean = mean(Arr_1000); 
% точечная оценка дисперсии
Arr_1000_Disp = var(Arr_1000);
% СКО
Arr_1000_Std = std(Arr_1000); 

% Расчитайте интервальные оценки среднего и дисперсия
alphas = [0.1, 0.05, 0.01];

% расчёт интервальной оценки среднего для выборки 50 
Arr_50_3_Mean_intervals = cell(1,length(alphas)); 
Arr_50_18_Mean = mean(Arr_50(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_50(1:18))) / sqrt(18));

    Arr_50_3_Mean_intervals{i} = [Arr_50_18_Mean - k_STD * margin_of_error, Arr_50_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 50 

Arr_50_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_50(1:18))*(18-1);

    Arr_50_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end 

% расчёт интервальной оценки среднего для выборки 200 
Arr_200_3_Mean_intervals = cell(1,length(alphas)); 
Arr_200_18_Mean = mean(Arr_200(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_200(1:18))) / sqrt(18));

    Arr_200_3_Mean_intervals{i} = [Arr_200_18_Mean - k_STD * margin_of_error, Arr_200_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 200 

Arr_200_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_200(1:18))*(18-1);

    Arr_200_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end

% расчёт интервальной оценки среднего для выборки 1000 
Arr_1000_3_Mean_intervals = cell(1,length(alphas)); 
Arr_1000_18_Mean = mean(Arr_1000(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_1000(1:18))) / sqrt(18));

    Arr_1000_3_Mean_intervals{i} = [Arr_1000_18_Mean - k_STD * margin_of_error, Arr_1000_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 1000 

Arr_1000_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_1000(1:18))*(18-1);

    Arr_1000_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end

k_50 = ceil(1 + 3.2 * log(50));
k_200 = ceil(1 + 3.2 * log(200)); 
k_1000 = ceil(1 + 3.2 * log(1000));

figure; 
    subplot(3, 1, 1); 
    histogram(Arr_50, k_50);
    xlabel('Значения');
    ylabel('Количество');

    subplot(3,1,2); 
    histogram(Arr_200, k_200); 
    xlabel('Значения');
    ylabel('Количество');

    subplot(3,1,3);
    histogram(Arr_1000, k_1000); 
    xlabel('Значения');
    ylabel('Количество');

figure; 
    subplot(3, 1, 1); 
    histogram(Arr_50, k_50, "Normalization", "pdf", 'DisplayStyle', 'stairs', "EdgeColor", 'r', 'DisplayName', "Эксперементальная плотность");
    hold on; 
        fplot(f,[min(Arr_50), max(Arr_50)],"Color", 'b', 'DisplayName', "Теоретическая плотность");
    hold off; 
    xlabel('x');
    ylabel('f(x)');
    legend show;

    subplot(3,1,2); 
    histogram(Arr_200, k_200, "Normalization", "pdf", 'DisplayStyle', 'stairs', "EdgeColor", 'r', 'DisplayName', "Эксперементальная плотность"); 
    hold on;
        fplot(f,[min(Arr_200), max(Arr_200)],"Color", 'b', 'DisplayName', "Теоретическая плотность");
    hold off; 
    xlabel('x');
    ylabel('f(x)');
    legend show;

    subplot(3,1,3);
    histogram(Arr_1000, k_1000, "Normalization", "pdf", 'DisplayStyle', 'stairs', "EdgeColor", 'r', 'DisplayName', "Эксперементальная плотность");
    hold on; 
        fplot(f,[min(Arr_1000), max(Arr_1000)],"Color", 'b', 'DisplayName', "Теоретическая плотность");
    hold off; 
    xlabel('x');
    ylabel('f(x)');
    legend show;

figure;
    fplot(f, [a, b], 'r');  % Теоретическая плотность
    hold on;
    fplot(F, [a, b], 'b');  % Функция распределения
    hold off;

% Дискретная величина 

Arr_50_D = generateDescrete(@P, 50); 
Arr_200_D = generateDescrete(@P, 200); 
Arr_1000_D = generateDescrete(@P, 1000);

% Конец генерации выборки 

% точечные оценки среднего, дисперсии и среднеквадратического отклонения (СКО)
% точечная оценка среднего (математичекое ожидание) 
Arr_50_D_Mean = mean(Arr_50_D); 
% точечная оценка дисперсии
Arr_50_D_Disp = var(Arr_50_D);
% СКО
Arr_50_D_Std = std(Arr_50_D); 
% точечная оценка среднего (математичекое ожидание) 
Arr_200_D_Mean = mean(Arr_200_D); 
% точечная оценка дисперсии
Arr_200_D_Disp = var(Arr_200_D);
% СКО
Arr_200_D_Std = std(Arr_200_D); 
% точечная оценка среднего (математичекое ожидание) 
Arr_1000_D_Mean = mean(Arr_1000_D); 
% точечная оценка дисперсии
Arr_1000_D_Disp = var(Arr_1000_D);
% СКО
Arr_1000_D_Std = std(Arr_1000_D); 

% Расчитайте интервальные оценки среднего и дисперсия
alphas = [0.1, 0.05, 0.01];

% расчёт интервальной оценки среднего для выборки 50 
Arr_50_D_3_Mean_intervals = cell(1,length(alphas)); 
Arr_50_D_18_Mean = mean(Arr_50_D(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_50_D(1:18))) / sqrt(18));

    Arr_50_D_3_Mean_intervals{i} = [Arr_50_D_18_Mean - k_STD * margin_of_error, Arr_50_D_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 50 

Arr_50_D_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_50_D(1:18))*(18-1);

    Arr_50_D_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end 

% расчёт интервальной оценки среднего для выборки 200 
Arr_200_D_3_Mean_intervals = cell(1,length(alphas)); 
Arr_200_D_18_Mean = mean(Arr_200_D(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_200_D(1:18))) / sqrt(18));

    Arr_200_D_3_Mean_intervals{i} = [Arr_200_D_18_Mean - k_STD * margin_of_error, Arr_200_D_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 200 

Arr_200_D_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_200_D(1:18))*(18-1);

    Arr_200_D_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end

% расчёт интервальной оценки среднего для выборки 1000 
Arr_1000_D_3_Mean_intervals = cell(1,length(alphas)); 
Arr_1000_D_18_Mean = mean(Arr_1000_D(1:18));

for i=1:length(alphas)
    k_STD = tinv(1 - alphas(i) / 2, 18 - 1);
    
    margin_of_error = k_STD * (sqrt(var(Arr_1000_D(1:18))) / sqrt(18));

    Arr_1000_D_3_Mean_intervals{i} = [Arr_1000_D_18_Mean - k_STD * margin_of_error, Arr_1000_D_18_Mean + k_STD * margin_of_error];
end 

% расчёт интервальной дисперсии для выборки 1000 

Arr_1000_D_3_Disp_intervals = cell(1,length(alphas)); 

for i=1:length(alphas)
    chiSQLeft = chi2inv((alphas(i)) / 2, 18 - 1);
    chiSQRight = chi2inv((1 - alphas(i)) / 2, 18 - 1);

    distrDisp = var(Arr_1000_D(1:18))*(18-1);

    Arr_1000_D_3_Disp_intervals{i} = [distrDisp / chiSQLeft, distrDisp / chiSQRight];
end

k_max = 5;
k_values = 1:5;
probabilities = [0.2,0.2,0.2,0.2,0.2];

% Размеры выборок
N1 = 50;
N2 = 200;
N3 = 1000;

% Генерация выборок дискретной случайной величины
x1_discrete = randsample(k_values, N1, true, probabilities);  
x2_discrete = randsample(k_values, N2, true, probabilities);  
x3_discrete = randsample(k_values, N3, true, probabilities);

% Эмпирические распределения
empirical_prob_1 = histcounts(x1_discrete, 'Normalization', 'probability', 'BinEdges', 0.5:1:5.5);
empirical_prob_2 = histcounts(x2_discrete, 'Normalization', 'probability', 'BinEdges', 0.5:1:5.5);
empirical_prob_3 = histcounts(x3_discrete, 'Normalization', 'probability', 'BinEdges', 0.5:1:5.5);

bin_width = 0.4;

figure;

% Для N=50
subplot(3,1,1);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_1, 'BarWidth', bin_width, 'FaceColor', 'b');

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_1(i) + 0.02, num2str(empirical_prob_1(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=50');
legend('Теоретическое распределение', 'Эмпирическое распределение');
hold off;

% Для N=200
subplot(3,1,2);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_2, 'BarWidth', bin_width, 'FaceColor', 'b');

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_2(i) + 0.02, num2str(empirical_prob_2(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=200');
legend('Теоретическое распределение', 'Эмпирическое распределение');
hold off;

% Для N=1000
subplot(3,1,3);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_3, 'BarWidth', bin_width, 'FaceColor', 'b');

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_3(i) + 0.02, num2str(empirical_prob_3(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=1000');
legend('Теоретическое распределение', 'Эмпирическое распределение');
hold off;

figure;

% Для N=50
subplot(3,1,1);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_1, 'BarWidth', bin_width, 'FaceColor', 'b');

% Построение теоретической плотности
x_plot = linspace(1, 5, 100);
y_plot = arrayfun(@(k) probabilities(k), round(x_plot)); % Здесь вы можете использовать свои вероятности
plot(x_plot, y_plot, 'k-', 'LineWidth', 2); % Черная линия для теоретической плотности

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_1(i) + 0.02, num2str(empirical_prob_1(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=50');
legend('Теоретическое распределение', 'Эмпирическое распределение', 'Теоретическая плотность');
hold off;

% Для N=200
subplot(3,1,2);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_2, 'BarWidth', bin_width, 'FaceColor', 'b');

% Построение теоретической плотности
plot(x_plot, y_plot, 'k-', 'LineWidth', 2); % Черная линия для теоретической плотности

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_2(i) + 0.02, num2str(empirical_prob_2(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=200');
legend('Теоретическое распределение', 'Эмпирическое распределение', 'Теоретическая плотность');
hold off;

% Для N=1000
subplot(3,1,3);
hold on;
bar(k_values - bin_width/2, probabilities, 'BarWidth', bin_width, 'FaceColor', 'r');
bar(k_values + bin_width/2, empirical_prob_3, 'BarWidth', bin_width, 'FaceColor', 'b');

% Построение теоретической плотности
plot(x_plot, y_plot, 'k-', 'LineWidth', 2); % Черная линия для теоретической плотности

for i = 1:length(k_values)
    text(k_values(i) - bin_width/2, probabilities(i) + 0.02, num2str(probabilities(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(k_values(i) + bin_width/2, empirical_prob_3(i) + 0.02, num2str(empirical_prob_3(i), '%.5f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('Теоретическое и экспериментальное распределение, N=1000');
legend('Теоретическое распределение', 'Эмпирическое распределение', 'Теоретическая плотность');
hold off;

% Кумулятивные вероятности
cumulative_probabilities = cumsum(probabilities);

% Создаем график
figure;

% График теоретической функции распределения вероятностей
subplot(2, 1, 1);
bar(k_values, probabilities, 'FaceColor', 'r');
hold on;
plot(k_values, cumulative_probabilities, 'k-', 'LineWidth', 2); % Кумулятивная вероятность
title('Теоретическая функция распределения вероятностей');
xlabel('k');
ylabel('Вероятность');
legend('P(X=k)', 'F(X)');
hold off;

% График плотности распределения вероятности
subplot(2, 1, 2);
bar(k_values, probabilities, 'FaceColor', 'b', 'BarWidth', 0.4);
hold on;

% Плотность для значений k
x_plot = linspace(1, 5, 100);
y_plot = interp1(k_values, probabilities, x_plot, 'linear', 'extrap'); % Интерполяция для плотности

% Отображаем теоретическую плотность
plot(x_plot, y_plot, 'k-', 'LineWidth', 2); % Теоретическая плотность
title('Теоретическая плотность распределения вероятности');
xlabel('k');
ylabel('Плотность');
legend('Плотность P(X=k)', 'Теоретическая плотность');
hold off;

% доп задание

theoretical_mean = (a + b) / 2;
theoretical_variance = (b - a)^2 / 12;

fprintf('Теоретическое математическое ожидание: %.4f\n', theoretical_mean);
fprintf('Теоретическая дисперсия: %.4f\n', theoretical_variance);

mean_x1 = mean(x1_discrete);
mean_x2 = mean(x2_discrete);
mean_x3 = mean(x3_discrete);

fprintf('Экспериментальное математическое ожидание для N=50: %.4f\n', mean_x1);
fprintf('Экспериментальная дисперсия для N=50: %.4f\n', Arr_50_Disp);
fprintf('Экспериментальное математическое ожидание для N=200: %.4f\n', mean_x2);
fprintf('Экспериментальная дисперсия для N=200: %.4f\n', Arr_200_Disp);
fprintf('Экспериментальное математическое ожидание для N=1000: %.4f\n', mean_x3);
fprintf('Экспериментальная дисперсия для N=1000: %.4f\n', Arr_1000_Disp);

N = 1000;
normal_sample = randn(N, 1);

skewness_value = skewness(normal_sample);
kurtosis_value = kurtosis(normal_sample);

fprintf('Коэффициент асимметрии: %.4f\n', skewness_value);
fprintf('Коэффициент эксцесса: %.4f\n', kurtosis_value);


alphas2 = [0.9, 0.95, 0.99];

for alpha1 = alphas2
    fprintf('Тест Колмогорова-Смирнова для уровня значимости %.2f:\n', alpha1);
    
    [h1, p1] = kstest((Arr_50 - a) / (b - a), 'Alpha', alpha1); % N = 50
    fprintf('N=50: h = %d, p = %f\n', h1, p1);
    
    [h2, p2] = kstest((Arr_200 - a) / (b - a), 'Alpha', alpha1); % N = 200
    fprintf('N=200: h = %d, p = %f\n', h2, p2);
    
    [h3, p3] = kstest((Arr_1000 - a) / (b - a), 'Alpha', alpha1); % N = 1000
    fprintf('N=1000: h = %d, p = %f\n\n', h3, p3);
end

function z = P(k)
    if (k >= 1 && k <= 5)
        z = 0.2;
    else 
        z = 0; 
    end 
end 