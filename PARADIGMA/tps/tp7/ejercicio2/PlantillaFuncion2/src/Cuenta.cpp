/*
 * Cuenta.cpp
 *
 *  Created on: Sep 26, 2010
 *      Author: hector
 */

#include <iostream>
#include "Cuenta.h"
using namespace std;

Cuenta::Cuenta(int numero, double saldo) :
	numero(numero), saldo(saldo) {
	//cout << "Constructor de Cuenta (Clase Base)"<<endl;

}

Cuenta::Cuenta(const Cuenta &cuenta) :
	numero(cuenta.numero), saldo(cuenta.saldo) {
	//cout << "Constructor de Cuenta (Clase Base)"<<endl;
}


int Cuenta::getNumero() const {
	return numero;
}

bool Cuenta::depositar(double cantidad) {
	bool resultado=false;
	if (cantidad>0){
		saldo = saldo + cantidad;
		resultado=true;
	}
	return resultado;
}
bool Cuenta::extraer(double cantidad) {
	bool resultado = false;
	if (cantidad <= saldo) {
		saldo = saldo - cantidad;
		resultado = true;
	}
	return resultado;
}

double Cuenta::getSaldo() const {
	return saldo;
}

Cuenta::~Cuenta() {
	//cout << endl << "Cuenta " << this->numero << " destruida" << endl;

}
