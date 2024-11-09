//============================================================================
// Name        : PlantillaPila.cpp
// Author      : CW
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>


#include "PilaGenerica.h"

#include "PilaInt.h"
#define MAX 10

using namespace std;



int main() {
	Pila<int> pInt;
	int i=0;
	for(i=0; i<MAX;i++ )
		pInt.push(i+1);
	pInt.escribir();


	cout << endl<<" Pop: " <<pInt.pop();
	if(pInt.esPilavacia())
		cout << endl<<" EsPilaVacia"<< endl;
	cout << endl<<" Tope: " <<pInt.top()<< endl;

	cout << endl<<"------------------------------------------------------------------------------ " << endl;


	Pila<char> pChar;
	for(int i='a'; i<'a'+MAX;i++ )
		pChar.push(i);
	pChar.escribir();

	cout << endl<<"------------------------------------------------------------------------------ " << endl;


	string numeros[MAX] ={ "uno", "dos","tres","cuatro","cinco","seis","siete","ocho","nueve","diez"};
	Pila<string> pString;
		for(int i=0; i<MAX;i++ )
			pString.push(numeros[i]);
		pString.escribir();

	return 0;
}
