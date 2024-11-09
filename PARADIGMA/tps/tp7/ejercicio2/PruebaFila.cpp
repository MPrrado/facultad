//============================================================================
// Name        : TP4 - PruebaFila.cpp
// Author      : C�tedra Paradigmas de Programaci�n - FACET - UNT
//============================================================================

#include "Fila.h"
#include "Iterador.h"
#include "Fecha.h"

using namespace std;

template<class X>
int contarX(Fila<X> F, X x);

int main() {

	// Creo un objeto fila con el constructor por defecto
	Fila<Fecha> F;

	// Controlo si la fila fue inicializada correctamente con el constructor
	if(F.EsFilaVacia())
		cout<<"CORRECTO - La Fila esta vacia"<<endl;
	else
		cout<<"ERROR - La Fila deberia estar vacia"<<endl;

	// Ingreso 3 items a la fila muestro el frente de la fila y la fila completa
	F.Enfila(*new Fecha());
	F.Enfila(*new Fecha(14,2,2003));
	F.Enfila(*new Fecha(23,10,1999));
	F.Enfila(*new Fecha(1,1,2000));
	F.Enfila(*new Fecha(1,1,2000));

	cout<<"El frente de la fila es: "<<F.Frente().toString()<<endl;

	cout<<"Contenido de la fila luego de insertar 3 items"<<endl;
	F.Mostrar();

	// Escribo la longitud de la fila 
	cout<<endl;
	cout<<"Longitud de la fila luego de insertar 3 items: "<<F.Longitud()<<endl;

	// Elimino el frente de la fila y muestro la fila
	F.Defila();

	cout<<"Contenido de la fila luego de eliminar el frente"<<endl;
	F.Mostrar();

	// Pruebo la operaci�n Pertenece con un elemento que se encuentra en la fila 
	cout<<endl;
	Fecha fecBuscada(23,10,1999);
	if(F.Pertenece(fecBuscada))
			cout<<"CORRECTO - El elemento pertenece a la fila"<<endl;
		else
			cout<<"ERROR - El elemento NO pertence a la fila"<<endl;

	// Pruebo la operaci�n Pertenece con un elemento que se encuentra en la fila 
	cout<<endl;
	Fecha fecBuscada1(1,1,1999);
	if(F.Pertenece(fecBuscada1))
			cout<<"ERROR - El elemento SI pertenece a la fila"<<endl;
		else
			cout<<"CORRECTO - El elemento NO pertence a la fila"<<endl;

	// PUNTO 4) c.

	Fecha fecBuscada2(1,1,2000);
	// Invoco a la operacion externa contarX que trabaja sobre una copia local del par�metro fila
	int cantidad = contarX<Fecha>(F, fecBuscada2);

	cout<<"Cantidad de elenentos iguales a X:  "<<cantidad<<endl;


	// Muestro por pantalla la fila luego de la invocacion a la operaci�n mostrar
	cout<<"Muestro por pantalla la fila luego de invocar a la operacion externa contarX"<<endl;
	F.Mostrar();
	

	return 0 ;
}
template<class X>
int contarX(Fila<X> F, X x){

	//Implementar 
	int contador = 0;
	Iterador<X> i(F);
	while(i.HayMasElementos())
	{
		if(i.GetDatoNodo() == x)
		{
			contador++;
		}
		i.Avanzar();
	}
	return contador;
}