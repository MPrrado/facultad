#include <stdio.h>  
// Se incluye la biblioteca estándar de entrada/salida. Permite usar funciones como printf para mostrar mensajes en la consola.

#include <sys/types.h>  
// Esta biblioteca define tipos de datos fundamentales para el sistema, como pid_t (identificador de proceso).  
// Es importante para la manipulación y comparación de valores relacionados con procesos.

#include <unistd.h>  
// Se incluye la biblioteca POSIX que provee funciones para gestión de procesos, 
// incluyendo fork (para crear procesos) y getpid (para obtener el identificador del proceso actual).

// Función que ejemplifica el uso de fork para crear un nuevo proceso:
void forkexample()
{
    // La función fork() crea un proceso nuevo duplicando al proceso en ejecución.
    // En el proceso hijo, fork() devuelve 0; en el proceso padre, devuelve el PID del hijo.
    if(fork() == 0) // Si fork() retorna 0, nos encontramos en el proceso hijo.
    {
        // En el proceso hijo, se imprime un mensaje junto con su PID (identificador de proceso).
        printf("soy el proceso hijo y mi PID es: %d\n", getpid());
    }
    else  // En el proceso padre, fork() retorna un valor mayor a 0 (el PID del hijo).
    {
        // En el proceso padre, se imprime un mensaje junto con su propio PID.
        printf("soy el proceso padre y mi PID es: %d\n", getpid());
    }
}

// Función principal del programa:
int main()
{
    // Se llama a la función forkexample para ejecutar el ejemplo de creación de procesos.
    forkexample();
    
    // La función main retorna 0 para indicar que el programa finalizó correctamente.
    return 0;
}

int main()
{
    printf("A\n");
    fork();
    printf("B\n");
    return 0;
}

