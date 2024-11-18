#include "IteradorInverso.h"
#include "IteradorPar.h"

void MostrarContenido(IteradorInverso &iterador);
int main()
{
    Contenedor C(5,9999);
    IteradorInverso i(C); 
    MostrarContenido(i);
    return 0;
}

void MostrarContenido(IteradorInverso &iterador)
{
    while(iterador.HayElementos())
    {
        cout<<iterador.GetDatoContenedor()<<"-";
        iterador.Avanzar();
    }   
}

