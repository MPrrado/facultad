/*
 * CuentaObjeto.h
 *
 */

#ifndef CUENTAOBJETO_H_
#define CUENTAOBJETO_H_
#include <iostream>
using namespace std;


class CuentaObjeto {

	static int objCreados;
	static int objDestruidos;
public:
	CuentaObjeto();
	CuentaObjeto(CuentaObjeto &co);
	CuentaObjeto& metodo1(CuentaObjeto &co);
	CuentaObjeto metodo2(CuentaObjeto co);
	static void mostrarResumen();
	virtual ~CuentaObjeto();
};

#endif /* CUENTAOBJETO_H_ */

