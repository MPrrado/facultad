//============================================================================
// Name        : EjercicioCuentaObjeto.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "CuentaObjeto.cpp"
using namespace std;

int main() {
	cout<<"Invococin al constructor por defecto"<<endl;
	CuentaObjeto obj1;
	cout<<"(Fin constructor por defecto)"<<endl;
	cout<<endl<<"   1 Resumen"<<endl;
	CuentaObjeto::mostrarResumen();
	{
		cout<<"Invocacin al constructor copia"<<endl;
		CuentaObjeto obj2(obj1);
		cout<<"(Fin constructor copia)"<<endl;
		cout<<endl<<"   2 Resumen"<<endl;
		CuentaObjeto::mostrarResumen();

		cout<<"Invocacin al constructor por defecto a travs del operador NEW"<<endl;
		CuentaObjeto *obj3 = new CuentaObjeto();
		cout<<"(Fin constructor por defecto)"<<endl;
		cout<<endl<<"   3 Resumen"<<endl;
		CuentaObjeto::mostrarResumen();

		cout<<"Invocacin a la funcin miembro metodo1"<<endl;
		obj1 = obj2.metodo1(obj1);
		cout<<"(Fin metodo1)"<<endl;
		cout<<endl<<"   4 Resumen"<<endl;
		CuentaObjeto::mostrarResumen();

		cout<<"Invocacin a la funcin miembro metodo2"<<endl;
		obj1 = obj3->metodo2(obj1);
		cout<<"(Fin metodo2)"<<endl;
		cout<<endl<<"   5 Resumen"<<endl;
		CuentaObjeto::mostrarResumen();
	}
	cout<<endl<<"   6 Resumen"<<endl;
	CuentaObjeto::mostrarResumen();


	return 0;
}
