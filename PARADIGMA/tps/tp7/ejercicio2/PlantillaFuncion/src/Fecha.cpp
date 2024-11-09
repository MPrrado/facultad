/*
 * Fecha.cpp
 *
 *  Created on: Oct 4, 2010
 *      Author: hector
 */

#include "Fecha.h"
#include <iostream>
#include <ctime>

using namespace std;

Fecha::Fecha() {
	setFechaActual();
}
Fecha::Fecha(short int d, short int m, short int a) {
	setFecha(d, m, a);
}
Fecha::Fecha(const Fecha &f) :
	dia(f.dia), mes(f.mes), anio(f.anio) {
}

void Fecha::setFechaActual(void) {
	struct tm *ptr;
	time_t sec;

	time(&sec);
	ptr = localtime(&sec);
	dia = (short) ptr->tm_mday;
	mes = (short) ptr->tm_mon + 1;
	anio = (short) ptr->tm_year + 1900;
}

void Fecha::setFecha(const short d, const short m, const short a) {
	dia = d;
	mes = m;
	anio = a;
	if(!esAnioValido() || !esMesValido() || !esDiaValido()){
		setFechaActual();
	}
}

bool Fecha::esAnioValido() const {
	return (anio > 0);
}
bool Fecha::esMesValido() const {
	return (mes >= 1 && mes <= 12);
}
bool Fecha::esDiaValido() const {
	return (dia >= 1 && dia <= diasEnMes(mes));
}

short Fecha::diasEnMes(const short m) const{
	short cantidadDias = 0;
	switch (m) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			cantidadDias = 31;
			break;
		case 2:
			if (esAnioBisiesto()) {
				cantidadDias = 29;
			} else {
				cantidadDias = 28;
			}
			break;
		case 4:
		case 6:
		case 9:
		case 11:
			cantidadDias = 30;
			break;
	}
	return cantidadDias;
}


bool Fecha::esAnioBisiesto() const {
	return ((anio % 4 == 0 && anio % 100 != 0) || anio % 400 == 0);
}

void Fecha::incrementarDia(void) {
	dia++;
	if (!esDiaValido()) {
		dia = 1;
		incrementarMes();
	}
}
void Fecha::incrementarMes(void) {
	mes++;
	if (!esMesValido()) {
		mes = 1;
		incrementarAnio();
	}
}
void Fecha::incrementarAnio(void) {
	anio++;
}
void Fecha::sumar(int dias) {
	while (dias) {
		incrementarDia();
		dias--;
	}
}

short Fecha::getDia() const {
	return dia;
}
short Fecha::getMes() const {
	return mes;
}
short Fecha::getAnio() const {
	return anio;
}
