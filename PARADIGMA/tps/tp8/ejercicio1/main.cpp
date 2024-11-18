#include "Contenedor.h"
#include "IteradorInverso.h"
#include "IteradorPar.h"

void MostrarContenido(Contenedor &C, IteradorInverso &iterador); //tengo que poner el & para pasarle la referencia directamente sino llamara al constructor copia
                                                                //pero en este caso nomas hago esto pues no tengo que modificar Contenedor.h
void MostrarContenido(Contenedor &C, IteradorPar &iterador);
int main()
{
    Contenedor C(5,9999);
    IteradorInverso i(C); 
    MostrarContenido(C, i);
    return 0;
}

void MostrarContenido(Contenedor &C, IteradorInverso &iterador)
{
    while(iterador.HayElementos())
    {
        cout<<iterador.GetDatoContenedor()<<"-";
        iterador.Retroceder();
        cout<<"-";
    }
    
}

void MostrarContenido(Contenedor &C, IteradorPar &iterador)
{
      while(iterador.HayElementos())
    {
        cout<<iterador.GetDatoContenedor()<<"-";
        iterador.Avanzar();
        cout<<"-";
    }
}
