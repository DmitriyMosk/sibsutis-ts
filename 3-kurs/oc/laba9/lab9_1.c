#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ROUTES 10
#define MAX_NAME_LENGTH 50

// Структура для записи маршрута
typedef struct {
    char start[MAX_NAME_LENGTH];
    char end[MAX_NAME_LENGTH];
    int route_number;
} Route;

// Функция для создания файла с маршрутами
void createFile(const char *filename) {
    FILE *file = fopen(filename, "wb");
    if (file == NULL) {
        perror("Ошибка при создании файла");
        exit(1);
    }

    Route routes[MAX_ROUTES] = {
        {"CityA", "CityB", 1},
        {"CityB", "CityC", 2},
        {"CityD", "CityA", 3},
        {"CityE", "CityF", 4},
        {"CityA", "CityG", 5},
        {"CityH", "CityI", 6},
        {"CityJ", "CityK", 7},
        {"CityL", "CityM", 8},
        {"CityN", "CityA", 9},
        {"CityO", "CityP", 10}
    };

    fwrite(routes, sizeof(Route), MAX_ROUTES, file);
    fclose(file);
}

// Функция для поиска маршрутов по введенному пункту
void searchRoute(const char *filename, const char *point) {
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        perror("Ошибка при открытии файла");
        exit(1);
    }

    Route route;
    int found = 0;

    printf("Маршруты, начинающиеся или заканчивающиеся в пункте '%s':\n", point);
    while (fread(&route, sizeof(Route), 1, file) == 1) {
        if (strcmp(route.start, point) == 0 || strcmp(route.end, point) == 0) {
            printf("Маршрут #%d: %s -> %s\n", route.route_number, route.start, route.end);
            found = 1;
        }
    }

    if (!found) {
        printf("Маршрутов, начинающихся или заканчивающихся в пункте '%s', не найдено.\n", point);
    }

    fclose(file);
}

int main() {
    const char *filename = "Spravka.dat";

    // Создаем файл с маршрутами
    createFile(filename);

    // Ввод названия пункта для поиска
    char point[MAX_NAME_LENGTH];
    printf("Введите название пункта для поиска: ");
    fgets(point, MAX_NAME_LENGTH, stdin);
    point[strcspn(point, "\n")] = '\0';  // Убираем символ новой строки

    // Поиск маршрутов по введенному пункту
    searchRoute(filename, point);

    return 0;
}
