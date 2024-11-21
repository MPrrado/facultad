#include "IteradorInverso.h"
#include "IteradorPar.h"

template <class X>
void MostrarContenido(IteradorInverso<X> &iterador);

template <class X>
void MostrarContenido(IteradorPar<X> &iterador);
int main()
{
    Contenedor C(5,"-");
    C.insertarElemento("h",0);
    C.insertarElemento("o",1);
    C.insertarElemento("l",2);
    C.insertarElemento("a",3);
    // C.insertarElemento(104,4);
    // IteradorPar i(C); 
    IteradorInverso i(C); 
    MostrarContenido(i);
    return 0;
}

template <class X>
void MostrarContenido(IteradorInverso<X> &iterador)
{
    while(iterador.HayElementos())
    {
        cout << iterador.GetDatoContenedor()<<endl;
        iterador.Avanzar();
    }
}

template <class X>
void MostrarContenido(IteradorPar<X> &iterador)
{
    while(iterador.HayElementos())
    {
        cout << iterador.GetDatoContenedor()<<endl;
        iterador.Avanzar();
    }
}

