/*
 * Derivada.h
 *
 *  Created on: 7/11/2014
 *      Author: Graciela
 */

#ifndef DERIVADA_H_
#define DERIVADA_H_
#include <iostream>

#include "Base.h"

namespace std {

class Derivada: public Base {
public:
	Derivada(){};
	void escribir(){
			cout << "Escribir de Clase Derivada" << endl;
	};
	~Derivada(){
			cout << "Destructor de Clase Derivada" << endl;
		}

	void print(){
		cout << "Clase Derivada" << endl;
	}


	/*
	Derivada& operator=(Base&){
		//En el cuerpo de la asignación hago una conversión de un O de clase Base en
		//un O de clase Derivada, asignando valores por defecto a los attb específicos
		//de la clase Derivada que no se encuentran presentes en la clase Base
		return *this;
	}
	 */
};

} /* namespace std */

#endif /* DERIVADA_H_ */
