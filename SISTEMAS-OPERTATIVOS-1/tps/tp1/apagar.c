#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Apagando el sistema...\n");

    // Ejecuta el comando de apagado
    int status = system("sudo shutdown -h now"); //ejecuta lo que le mandemos como parametro en la consola

    if (status == 0) {
        printf("El sistema se está apagando.\n");
    } else {
        printf("Hubo un error al intentar apagar el sistema.\n");
    }

    return 0;
}
