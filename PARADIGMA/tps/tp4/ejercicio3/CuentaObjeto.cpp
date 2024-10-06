/*
 * CuentaObjeto.cpp
 *
 */

#include "CuentaObjeto.h"

int CuentaObjeto::objCreados=0;
int CuentaObjeto::objDestruidos=0;

CuentaObjeto::CuentaObjeto() {
	objCreados++;
	cout<<"Const x defecto: "<<this<<endl;
}

CuentaObjeto::CuentaObjeto(CuentaObjeto &co){
	objCreados++;
	cout<<"Const copia: "<<this<<endl;
}
CuentaObjeto& CuentaObjeto::metodo1(CuentaObjeto &co){
	return co;
}	
CuentaObjeto CuentaObjeto::metodo2(CuentaObjeto co){
	return co;
}

void CuentaObjeto::mostrarResumen(){
	cout<<"      - Creados: "<<objCreados<<endl;
	cout<<"      - Destruidos: "<<objDestruidos<<endl<<endl;
}
CuentaObjeto::~CuentaObjeto(){
	objDestruidos++;
	cout<<"Destructor: "<<this<<endl;
}


