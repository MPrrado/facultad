#ifndef ITERADOR_H_
#define ITERADOR_H_
#include "Fila.h"
#include "Iterador.h"
class Iterador
{
    private:
        const Fila &fila;
        Nodo* actual;
    public:
        Iterador(const Fila &f):fila(f),actual(f.frenteFila){};
        Item GetDatoNodo();
        bool HayMasElementos();
        void Avanzar();
};

Item Iterador :: GetDatoNodo()
{
    return this->actual->getDato();
}

bool Iterador :: HayMasElementos()
{
    return actual != nullptr;
}

void Iterador :: Avanzar()
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