/*
 * Create.cpp
 */

#include "Create.h"
#include <iostream>

namespace std {

crearydestruir :: crearydestruir(int valor) //constructor sobrecargado
{
		data = valor;
		cout << "Objeto " << data << " constructor";
};

crearydestruir ::crearydestruir(crearydestruir& aux)	//constructor copia
{
			data = aux.data;
			cout << "Objeto " << data << " constructor copia";
}
crearydestruir::~crearydestruir() {
	// TODO Auto-generated destructor stub
	cout << "Objeto " << data << " destructor" << endl;
}

} /* namespace std */
