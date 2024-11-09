#ifndef LIBRERIA_H_
#define LIBRERIA_H_
#include "venta.h"

class Libreria
{
    private:
        int cantidadVentas;
        vector<Venta*> listaVentas;
        vector<Lectura*> stockArticulos;
    public:
        void CrearVenta(vector<Lectura*> listaArticulosVendidos);
        void CargarArticulo(Lectura *articuloNuevo);
        void ListarInfoVentaSegunFecha(Fecha* fecha);
        double CalcularTotalSegunMes(int mes, int anio);
        Libreria();
        ~Libreria();
};
#endif 