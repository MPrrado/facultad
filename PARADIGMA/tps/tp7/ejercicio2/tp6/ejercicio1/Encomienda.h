#include <iostream>
#include "Fecha.cpp"
#include "Vehiculo.cpp"
using namespace std;
class Encomienda
{
    static int autonumerico;
    int codigoEncomienda;
    string dirOrigen;
    string dirDestino;
    Fecha *fechaIngreso;
    Fecha *fechaEntrega;
    bool entregado;
    double pesoEncomienda;
    Vehiculo* vehiculoAcargo;
    public:
        void EscribirInfo();
        void SetFechaEntrega(Fecha *fecha);
        Fecha GetFechaEntrega();
        int GetCodigo();
        double CalcularPrecioEncomienda();
        double GetPeso();
        Encomienda();
        Encomienda(string dirOrigen, string dirDestino, double pesoEncomienda, Vehiculo* vehiculoAcargo);
        ~Encomienda();
};