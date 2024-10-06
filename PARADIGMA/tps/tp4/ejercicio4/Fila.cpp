#include <iostream>
using namespace std;
#include "Fila.h"

Nodo :: Nodo()
{
}

void Nodo :: setDato(Item dato)
{
    this->dato = dato;
}

Item Nodo :: getDato()
{
    return this->dato;
}

void Nodo :: setSiguiente(Nodo* nodoSiguiente)
{
    this->siguiente = nodoSiguiente;
}

Nodo* Nodo :: getSiguiente()
{
    return this->siguiente;
}

Fila :: Fila()
{
    this->longitud = 0;
    this->frenteFila = nullptr;
    this->finalFila = nullptr;
}

bool Fila :: EsFilaVacia()
{
    return (this->longitud == 0);
}

void Fila :: Enfila(Item dato)
{
    Nodo* nuevoNodo = new Nodo();
    nuevoNodo->setDato(dato);
    nuevoNodo->setSiguiente(nullptr);
    if(this->EsFilaVacia())
    {
        this->frenteFila = nuevoNodo;
        this->finalFila = nuevoNodo;
    }else
    {
        this->finalFila = nuevoNodo;
    }
    this->longitud++;
}

void Fila :: Defila()
{
    if(!this->EsFilaVacia())
    {
        Nodo* aux = this->frenteFila;
        this->frenteFila = this->frenteFila->getSiguiente();
        aux->setSiguiente(nullptr);
        delete aux;
        this->longitud--;
    }else
    {
        cout<<endl<<"ERROR NO HAY ELEMENTOS PARA BORRAR EN LA FILA"<<endl;
    }

}

Item Fila :: Frente()
{
    return this->frenteFila->getDato();
}

int Fila :: Longitud()
{
    return this->longitud;
}

bool Fila :: Pertenece(Item datoBuscado)
{
    Nodo* aux = this->frenteFila;
    bool bandera = false;
    while (aux->getSiguiente() != nullptr)
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