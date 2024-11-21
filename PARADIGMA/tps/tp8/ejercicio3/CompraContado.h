#ifndef COMPRACONTADO_H_
#define COMPRACONTADO_H_
#include "Compra.h"
class CompraContado : public Compra
{
    private:
        const double DESCUENTO;
    public:
        CompraContado(vector<Producto*> listaProductos, Fecha* fechaCompra);
        ~CompraContado();
        double calcularMonto();
        void escribirInfo();
};


#endif