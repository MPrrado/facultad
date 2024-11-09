#ifndef LECTURA_H_
#define LECTURA_H_
#include "Fecha.h"

class Lectura
{
protected:
    static int codigoAutoincremental;
    int codigo;
    string titulo;
    int anioEdicion;
    double precioBase;

public:
    int GetCodigo();
    virtual void MostrarInfo();
    double GetPrecioVenta();
    Lectura(string titulo, int anioEdicion, double precioBase);
    virtual ~Lectura()
    {
        
    };

protected:
    virtual double CalcularPrecioFinal() = 0;
};

#endif 