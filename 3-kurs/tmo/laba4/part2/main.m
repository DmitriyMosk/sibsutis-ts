% Задание размерностей векторов
I = 22;
J = 15;

[meanValue, varianceValue] = calculate_vectors(I, J);

function [meanValue, varianceValue] = calculate_vectors(I, J)
    vector_column = rand(I, 1);

    vector_row = rand(1, J);

    result_matrix = vector_column * vector_row;

    meanValue = mean(result_matrix(:));

    varianceValue = var(result_matrix(:));
    
    disp(['Среднее значение: ', num2str(meanValue)]);
    disp(['Дисперсия: ', num2str(varianceValue)]);
end

