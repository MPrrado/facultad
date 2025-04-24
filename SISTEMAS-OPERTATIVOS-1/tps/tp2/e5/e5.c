#include <stdio.h>
#include <unistd.h>
#include <time.h>

int main() {
    char cwd[256];
    time_t t;

    printf("\nINICIANDO...\n");
    getchar();
    getcwd(cwd, sizeof(cwd)); //obtengo el directorio actual
    printf("Directorio actual: %s\n", cwd);
    getchar();

    chdir("/tmp");// cambio de directorio
    getcwd(cwd, sizeof(cwd)); // obtengo el nuevo directorio
    printf("Nuevo directorio: %s\n", cwd); // imprimo el nuevo directorio
    getchar();

    t = time(NULL); // obtengo el tiempo actual
    printf("Tiempo actual: %ld\n", t); // imprimo el tiempo actual
    getchar();

    return 0;
}
