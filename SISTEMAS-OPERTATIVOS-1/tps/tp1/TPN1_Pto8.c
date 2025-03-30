#include <stdio.h>
#include <math.h>
#include <string.h>
int BinaryToDecimal(char* binario);
int main()
{
    char binario[33];
    puts("INGRESE EL NUMERO EN BINARIO: ");
    fgets(binario,33,stdin);
    printf("Numero ingresado en binario: %s", binario);
    int decimal = BinaryToDecimal(binario);
    printf("El numero pasado a decimal es: %i \n", decimal);
    return 0;
}

int BinaryToDecimal(char* binario)
{
    int decimal = 0;
    int longitudBinario = strlen(binario)-1; //quitamos uno porque tenemos el final de linea del string 
    for (int i = 0; i < longitudBinario; i++) //esto lo lee como si estuviera desde el primer bit mas significativo
    {
        if(binario[i] == '1') 
        {
            decimal+= pow(2, longitudBinario-1-i); //restamos uno a la longitud pues arranca desde 0 y ademas le restamos la posicion del ciclo para encontrar bien el valor del exponente
        }
    }
    return decimal;

}
