#ifndef ITERADOR_H_
#define ITERADOR_H_
#include "Fila.h"
template<class X>
class Iterador
{
    private:
        const Fila<X> &fila;
        Nodo<X>* actual;
    public:
        Iterador(const Fila<X> &f):fila(f),actual(f.frenteFila){};
        X GetDatoNodo();
        bool HayMasElementos();
        void Avanzar();
};

template<class X>
X Iterador<X> :: GetDatoNodo()
{
    return this->actual->getDato();
}
template<class X>
bool Iterador<X> :: HayMasElementos()
{
    return actual != nullptr;
}
template<class X>
void Iterador<X> :: Avanzar()
{
    if(actual == nullptr)
    {
        actual = nullptr;
    }else
    {
        actual = this->actual->getSiguiente();   
    }
}
#endif