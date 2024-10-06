#include <iostream>
#include "Pila.cpp"
using namespace std;


int main()
{
    Cuenta c1(123,44658689,500000);
    Cuenta c2(123,44658689,500000);
    Cuenta c3(123,44658689,500000);
    Cuenta c4(123,44658689,500000);
    Cuenta c5(123,44658689,500000);
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

    cout<<"Cargamos la pila con 5 cuentas"<<endl;

    pila.push(&c1);
    pila.push(&c2);
    pila.push(&c3);
    pila.push(&c4);
    pila.push(&c5);

    cout<<endl<<"Escribimos lo que tiene la pila (esperamos 5 direcciones de memoria)";
    pila.escribir();

    cout<<"Escribimos el tope de la pila:  "<<pila.top()<<endl;

    cout<<"Eliminamos el tope de la pila y mostramos las direcciones, esperamos las 4 primeras"<<endl;
    pila.pop();
    pila.escribir();

        
    return 0;
}

