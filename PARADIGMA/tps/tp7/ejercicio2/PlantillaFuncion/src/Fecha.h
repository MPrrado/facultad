/*
 * Fecha.h
 *
 *  Created on: Oct 4, 2010
 *      Author: hector
 */

#ifndef FECHA_H_
#define FECHA_H_

class Fecha {
private:
	short dia;
	short mes;
	short anio;
	bool esDiaValido() const;
	bool esMesValido() const;
	bool esAnioValido() const;
	short diasEnMes(const short mes) const;
public:
	Fecha();
	Fecha(const short d, const short m, const short a);
	Fecha(const Fecha &f);

	void setFechaActual(void);
	void setFecha(const short d, const short m, const short a);

	void incrementarDia(void);
	void incrementarMes(void);
	void incrementarAnio(void);
	void sumar(int dias);

	bool esAnioBisiesto(void) const;

	short getDia() const;
	short getMes() const;
	short getAnio() const;
	friend bool operator==(Fecha f1, Fecha f2){
		return (f1.dia==f2.dia && f1.mes==f2.mes && f1.anio==f2.anio);
	};

};

#endif /* FECHA_H_ */
