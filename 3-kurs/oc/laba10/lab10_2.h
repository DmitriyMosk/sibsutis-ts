#ifndef PROGRAM_H
#define PROGRAM_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

extern char **environ;  // Переменная для доступа к окружению

void print_author();
void print_env_variables(int method);
void print_file_content(const char *filename);

#endif
