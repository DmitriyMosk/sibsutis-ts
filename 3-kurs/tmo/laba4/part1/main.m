syms x; 

f = sin(x)^2 - exp(-2*x);
df = diff(f, x); 
F = int(f, x);

figure;

subplot(3, 1, 1);
fplot(matlabFunction(f), [0, 10]);
title('Функция f(x)');
xlabel('x');
ylabel('f(x)');
grid on;

subplot(3, 1, 2);
fplot(matlabFunction(df), [0, 10]);
title('Производная f(x)');
xlabel('x');
ylabel('df(x)/dx');
grid on;

subplot(3, 1, 3);
fplot(matlabFunction(F), [0, 10]);
title('Интеграл f(x)');
xlabel('x');
ylabel('∫f(x)dx');
grid on;
hold on;
% Добавим зарисовку площади под интегралом
x_vals = linspace(0, 10, 1000);
y_vals = arrayfun(matlabFunction(F), x_vals);
fill([x_vals fliplr(x_vals)], [zeros(1, length(x_vals)) fliplr(y_vals)], 'b', 'FaceAlpha', 0.3);
hold off;

a = 1;  % Коэффициент a
b = -0.5;  % Коэффициент b

g = a * x + b;  % Линейная функция

figure;
fplot(matlabFunction(f), [0, 10], 'DisplayName', 'f(x)');
hold on;
fplot(matlabFunction(g), [0, 10], 'DisplayName', 'a*x + b');
legend('show');
title('Графическое решение уравнения a*x + b = f(x)');
xlabel('x');
ylabel('y');
grid on;

f_anon = @(x) sin(x)^2 - exp(-2*x) - (a * x + b);  % Уравнение вида a*x + b = f(x)

initial_guess = 1;  % Начальное приближение
x_solution = fsolve(f_anon, initial_guess);

disp('Аналитическое решение уравнения:');
disp(x_solution);

syms y; 

F = sqrt(x^2 - y^2) / y;

F = sqrt(x^2 - y^2) / y;  % Определение функции

% Преобразование символической функции в анонимную функцию
F_handle = matlabFunction(F, 'Vars', [x, y]);

% Ограничение области определения
x_vals = linspace(-10, 10, 100);
y_vals = linspace(-10, 10, 100);
[X, Y] = meshgrid(x_vals, y_vals);
Z = F_handle(X, Y);

% Избегаем комплексных значений
Z(imag(Z) ~= 0) = NaN;

figure;
surf(X, Y, Z);
title('График функции F(x, y)');
xlabel('x');
ylabel('y');
zlabel('F(x, y)');
grid on;

% Добавление текстовых регионов с подписями
dim1 = [0.2 0.8 0.1 0.1];
annotation('textbox', dim1, 'String', 'График функции F(x, y)', 'FitBoxToText', 'on');

dim2 = [0.2 0.7 0.1 0.1];
annotation('textbox', dim2, 'String', 'График построен в виде поверхности', 'FitBoxToText', 'on');