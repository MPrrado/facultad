#include <stdio.h>
#include <string.h>
#include <math.h>

int binario_a_decimal(const char *binario) {
    int decimal = 0;
    int longitud = strlen(binario);

    for (int i = 0; i < longitud; i++) {
        if (binario[i] == '1') {
            decimal += pow(2, longitud - 1 - i);
        }
    }

    return decimal;
}

int main() {
    char binario[33]; // Para números binarios de hasta 32 bits + terminador de cadena

    printf("Ingrese un número binario: ");
    scanf("%s", binario);

    int decimal = binario_a_decimal(binario);

    printf("El número binario %s en decimal es: %d\n", binario, decimal);

    return 0;
}
