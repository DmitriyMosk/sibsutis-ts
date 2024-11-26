#include "lab10_2.h"

// Основная функция программы
int main(int argc, char *argv[]) {
    int method = 0;
    const char *filename = NULL;

    // Обработка аргументов командной строки
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-1") == 0) {
            method = 1;
        } else if (strcmp(argv[i], "-2") == 0) {
            method = 2;
        } else if (strcmp(argv[i], "-f") == 0) {
            if (i + 1 < argc) {
                filename = argv[++i];
            } else {
                fprintf(stderr, "Ошибка: не указано имя файла после опции -f.\n");
                print_author();
                return 1;
            }
        } else {
            fprintf(stderr, "Ошибка: неправильная опция '%s'. Используйте -1, -2 или -f <имя файла>.\n", argv[i]);
            print_author();
            return 1;
        }
    }

    // Выполнение действий в зависимости от опций
    if (method == 1 || method == 2) {
        print_env_variables(method);
    }

    if (filename != NULL) {
        print_file_content(filename);
    }

    print_author();
    return 0;
}

// Функция для вывода первых 10 переменных окружения
void print_env_variables(int method) {
    if (method == 1) {
        // Способ 1: Использование переменной окружения environ
        for (int i = 0; i < 10 && environ[i] != NULL; i++) {
            printf("ENV[%d]: %s\n", i, environ[i]);
        }
    } else if (method == 2) {
        // Способ 2: Использование функции getenv с конкретными именами
        const char *vars[] = {"PATH", "HOME", "SHELL", "USER", "LANG", "PWD", "LOGNAME", "TERM", "HOSTNAME", "DISPLAY"};
        for (int i = 0; i < 10; i++) {
            const char *value = getenv(vars[i]);
            if (value) {
                printf("ENV[%d] %s: %s\n", i, vars[i], value);
            }
        }
    } else {
        fprintf(stderr, "Ошибка: неправильный метод вывода переменных окружения.\n");
    }
}

// Функция для вывода содержимого файла на экран
void print_file_content(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        fprintf(stderr, "Ошибка при открытии файла '%s': %s\n", filename, strerror(errno));
        return;
    }

    char ch;
    while ((ch = fgetc(file)) != EOF) {
        putchar(ch);
    }

    if (ferror(file)) {
        fprintf(stderr, "Ошибка при чтении файла '%s'.\n", filename);
    }

    if (fclose(file) != 0) {
        fprintf(stderr, "Ошибка при закрытии файла '%s': %s\n", filename, strerror(errno));
    }
}

// Функция для вывода информации об авторе
void print_author() {
    printf("\nАвтор программы: Московских Д.П., Вариант: 4\n");
}