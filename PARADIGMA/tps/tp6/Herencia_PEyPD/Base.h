/*
 * Base.h
 *
 *  Created on: 7/11/2014
 *      Author: Graciela
 */

#ifndef BASE_H_
#define BASE_H_
#include <iostream>

namespace std {

class Base {
public:
	Base(){};
	virtual void escribir(){
		cout << "Escribir de Clase Base" << endl;
	};
	virtual ~Base(){
		cout << "Destructor de Clase Base" << endl;
	}
};

} /* namespace std */

#endif /* BASE_H_ */
