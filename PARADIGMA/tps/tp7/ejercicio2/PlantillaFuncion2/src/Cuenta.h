/*
 * Cuenta.h
 *
 *  Created on: Sep 26, 2010
 *      Author: hector
 */

#ifndef CUENTA_H_
#define CUENTA_H_

#include <iostream>
using namespace std;

class Cuenta {
protected:
	int numero;
	double saldo;
public:
	Cuenta(int numero=0, double saldo=0);
	Cuenta(const Cuenta &cuenta);
	virtual ~Cuenta();
	int getNumero() const;
	double getSaldo() const;
	bool depositar(double cantidad);
	bool extraer(double cantidad);
	friend bool operator==(Cuenta A, Cuenta B){
		if (A.numero == B.numero && A.saldo == B.saldo)
			return true;
		else
			return false;

	};

	friend ostream& operator <<(ostream& sale, Cuenta A){
		sale << "Cuenta"<<endl;
		sale<< "Numero : "<<A.numero<<endl;
		sale<< "Saldo: "<<A.saldo<<endl;
		return sale;

	};
};

#endif /* CUENTA_H_ */
