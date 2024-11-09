#ifndef FILA_H_
#define FILA_H_
#include <iostream>
#include "Fecha.h"
using namespace std;
template<class X>
class Nodo
{
    X dato;
    Nodo<X>* siguiente;
    public:
        Nodo();
        void setDato(X dato);
        X getDato();
        void setSiguiente(Nodo<X>* nodoSiguiente);
        Nodo<X>* getSiguiente();
        ~Nodo();

};
template<class X>
class Iterador;

template<class X>
class Fila
{
    int longitud;
    Nodo<X>* finalFila;
    Nodo<X>* frenteFila;
    public:
        Fila();
        Fila(const Fila &f);
        void Mostrar();
        int Longitud();
        bool Pertenece(X datoBuscado);
        void Enfila(X dato);
        void Defila();
        X Frente();
        bool EsFilaVacia();
        ~Fila();
        friend class Iterador<X>;
};

template<class X>
Nodo<X> :: Nodo()
{
}
template<class X>
Nodo<X> :: ~Nodo()
{
}
template<class X>
void Nodo<X> :: setDato(X dato)
{
    this->dato = dato;
}
template<class X>
X Nodo<X> :: getDato()
{
    return this->dato;
}
template<class X>
void Nodo<X> :: setSiguiente(Nodo<X>* nodoSiguiente)
{
    this->siguiente = nodoSiguiente;
}
template<class X>
Nodo<X>* Nodo<X> :: getSiguiente()
{
    return this->siguiente;
}
template<class X>
Fila<X> :: Fila()
{
    this->longitud = 0;
    this->frenteFila = nullptr;
    this->finalFila = nullptr;
}
template<class X>
Fila<X> :: Fila(const Fila<X> &f)
{
    Nodo<X>* aux = f.frenteFila;
    this->frenteFila = nullptr;
    this->finalFila = nullptr;
    this->longitud = 0;
    while(aux)
    {
        this->Enfila(aux->getDato());
        aux = aux->getSiguiente();
    }
}
template<class X>
void Fila<X> :: Mostrar()
{
    Nodo<X>*aux = this->frenteFila;
    while(aux != nullptr)
    {
        cout<<aux->getDato()<<"-";
        aux = aux->getSiguiente();
    }
}
template<>
void Fila<Fecha> :: Mostrar()
{
    Nodo<Fecha>*aux = this->frenteFila;
    while(aux != nullptr)
    {
        cout<<aux->getDato().toString()<<endl;
        aux = aux->getSiguiente();
    }
}
template<class X>
bool Fila<X> :: EsFilaVacia()
{
    return (this->longitud == 0);
}
template<class X>
void Fila<X> :: Enfila(X dato)
{
    Nodo<X>* nuevoNodo = new Nodo<X>();
    nuevoNodo->setDato(dato);
    nuevoNodo->setSiguiente(nullptr);
    if(this->EsFilaVacia())
    {
        this->frenteFila = nuevoNodo;
        this->finalFila = nuevoNodo;
    }else
    {
        this->finalFila->setSiguiente(nuevoNodo);
        this->finalFila = nuevoNodo;
    }
    this->longitud++;
}
template<class X>
void Fila<X> :: Defila()
{
    if(!EsFilaVacia())
    {
        Nodo<X>* aux = this->frenteFila;
        this->frenteFila = this->frenteFila->getSiguiente();
        aux->setSiguiente(nullptr);
        delete aux;
        this->longitud--;
    }else
    {
        cout<<endl<<"ERROR NO HAY ELEMENTOS PARA BORRAR EN LA FILA"<<endl;
    }

}
template<class X>
X Fila<X> :: Frente()
{
    return this->frenteFila->getDato();
}
template<class X>
int Fila<X> :: Longitud()
{
    return this->longitud;
}
template<class X>
bool Fila<X> :: Pertenece(X datoBuscado)
{
    Nodo<X>* aux = this->frenteFila;
    bool bandera = false;
    while (aux)
    {
        if(aux->getDato() == datoBuscado)
        {
            bandera = true;
            break;
        }
        aux = aux->getSiguiente();
    }
    return bandera;
}
template<class X>
Fila<X> :: ~Fila()
{
    while(!EsFilaVacia())
    {
        Defila();
    }
    this->longitud = 0;
}


#endif