#include <stdio.h>

int main()
{
    int variable, ciclos;

    printf("INGRESE UN NUMERO ENTRE 1 Y 20: \n");
    scanf("%d", &variable);
    while ((variable < 1) || (variable > 20))
    {
        printf("ERROR EL NUMERO INGRESADO DEBE ESTAR ENTRE 1 Y 20: \n");
        scanf("%d", &variable);
    }
    
    int anterior = 0, comienzo = 1, resultado;
    ciclos = variable;
    
    for (int i = 0; i < ciclos; i++)
    {
        if(i == 0)
        {
            printf("%d\n", anterior);    
        }else if(i == 1)
        {
            printf("%d\n", comienzo);
        }else
        {

            resultado = comienzo + anterior;
            anterior = comienzo;
            comienzo = resultado;
            printf("%d\n", resultado);
        }
    }
    
    getchar();
    getchar();
    
    return 0;
}