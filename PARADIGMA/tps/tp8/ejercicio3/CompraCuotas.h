#ifndef COMPRACUOTAS_H_
#define COMPRACUOTAS_H_
#include "Compra.h"
class CompraCuotas : public Compra
{
private:
    /* data */
    static const double INTERES3CUOTAS ;
    static const double INTERES6CUOTAS ;
    int cantidadCuotas;

public:
    CompraCuotas(vector<Producto*> listaProductos, Fecha* fechaCompra, int cantidadCuotas);
    ~CompraCuotas();
    void escribirInfo();
    double calcularMonto();    
};

#endif
