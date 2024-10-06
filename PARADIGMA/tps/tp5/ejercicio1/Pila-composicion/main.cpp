#include <iostream>
#include "Pila.cpp"
using namespace std;


// const double TRANSFERENCIA = 5000;
// bool Transferir(Cuenta &c1, Cuenta &c2);
int main()
{
    Pila pila;
    cout<<"Preguntamos si la pila esta vacia: (esperamos SI)"<<endl;

    if(pila.esPilavacia())
    {
        cout<<"SI ESTA VACIA"<<endl;
    }else
    {
        cout<<"NO ESTA VACIA"<<endl;
        
    }
    cout<<"Escribimos los datos de la pila: (esperamos vacio)";
    pila.escribir();

    pila.push(123,44658689,500000);
    pila.push(124,44658789,550000);
    pila.push(125,44658889,600000);
    pila.push(126,44658989,650000);
    pila.push(127,44651089,700000);

    cout<<endl<<"Escribimos lo que tiene la pila (esperamos 5 direcciones de memoria)";
    pila.escribir();

    cout<<"Escribimos el tope de la pila:  "<<pila.top()<<endl;

    cout<<"Eliminamos el tope de la pila y mostramos las direcciones, esperamos las 4 primeras"<<endl;
    pila.pop();
    pila.escribir();

    


    return 0;
}

