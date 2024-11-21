function [L, W] = calculate_stats(arrival_times, service_times)
    L = mean(arrival_times ./ service_times); % Среднее число заявок в системе
    W = mean(arrival_times); % Среднее время пребывания заявки
end