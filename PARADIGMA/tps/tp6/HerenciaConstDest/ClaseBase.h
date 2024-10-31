/*
 * ClaseBase.h
 */

#ifndef CLASEBASE_H_
#define CLASEBASE_H_

#include  <iostream>
using namespace std;

class ClaseBase{
protected:
	//Los datos miembros fueron declarados como protegidos para
	//que las funciones miembro de las clases derivadas puedan
	//acceder a ellos a través del nombre
	int dato1;
	char dato2;
public:
	ClaseBase():dato1(0), dato2('@'){
		cout <<"Constructor por defecto de ClaseBase"<<endl;
	}
	ClaseBase(int d1, char d2):dato1(d1),dato2(d2){
		cout <<"Constructor sobrecargado de ClaseBase"<<endl;
	}
	void print(){
		cout <<"PRINT de Clase Base:"<<endl<<"*  dato1 = "<<this->dato1<<endl<< "*  dato2 = "<<this->dato2<<endl;
	}
	~ClaseBase(){
		cout <<"Destructor de Clase Base"<<endl<<endl;
	}
};


#endif /* CLASEBASE_H_ */
