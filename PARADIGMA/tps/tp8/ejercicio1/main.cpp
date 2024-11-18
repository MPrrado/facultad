#include "IteradorInverso.h"

<<<<<<< HEAD
void MostrarContenido(Contenedor &C, IteradorInverso &iterador); //tengo que poner el & para pasarle la referencia directamente sino llamara al constructor copia
                                                                //pero en este caso nomas hago esto pues no tengo que modificar Contenedor.h
void MostrarContenido(Contenedor &C, IteradorPar &iterador);
=======
void MostrarContenido(IteradorInverso &iterador);
>>>>>>> 0a4b0e15555f829e26736044da28ee5b15240be1
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

