/*
 * ClaseDerivada1.h
 *
 *  Created on: 22/10/2016
 *      Author: Graciela
 */

#ifndef CLASEDERIVADA1_H_
#define CLASEDERIVADA1_H_

#include  <iostream>
#include "ClaseBase.h"
using namespace std;

class ClaseDerivada1:public ClaseBase{

	string datoDerivada;
public:
	//LLamada implícita al constructor de ClaseBase
	ClaseDerivada1():datoDerivada("Default"){
		cout <<"Constructor por defecto de ClaseDerivada1"<<endl;
	}
	//LLamada explícita al constructor de ClaseBase
	ClaseDerivada1(string dD, int dCB1=9,char dCB2='#' ):ClaseBase(dCB1, dCB2){
		this->datoDerivada=dD;
		cout <<"Constructor sobrecargado de ClaseDerivada1"<<endl;
	}
	void print(){
		cout <<"PRINT de ClaseDerivada1: "<<endl;
		cout<<"*  dato1 = "<<this->dato1<<endl;//Datos miembros heredados de ClaseBase
		cout<<"*  dato2 = "<<this->dato2<<endl;//Datos miembros heredados de ClaseBase
		cout<<"*  datoDerivada = "<<this->datoDerivada<<endl;
	}
	~ClaseDerivada1(){
		cout <<"Destructor de ClaseDerivada1"<<endl;
	}
};


#endif /* CLASEBASE_H_ */
