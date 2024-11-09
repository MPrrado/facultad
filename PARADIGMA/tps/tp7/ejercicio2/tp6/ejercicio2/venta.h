#ifndef VENTA_H_
#define VENTA_H_
#include "lectura.h"
#include <vector>
class Venta
{
    private:
        static int autoincremental;
        int codigoVenta;
        Fecha *fechaVenta;
        vector<Lectura*> articulosVendidos;
    public:
        Fecha GetFechaVenta();
        void MostarDatos();
        double CalcularTotal();
        Venta(vector<Lectura*> listaArticuloVenta);
        ~Venta();

};
#endif 