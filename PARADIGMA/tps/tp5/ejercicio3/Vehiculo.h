#include <iostream>
using namespace std;
class Vehiculo
{
    string patente;
    int anioModelo;
    double pesoMax;
    static const int INCREMENTO;
    double tarifa;
    public:
        void EscribirInfo();
        double GetTarifa();
        double calcularPrecioViaje(double peso);
        Vehiculo();
        Vehiculo(string patente, int anioModelo, double pesoMax, double tarifa);
        ~Vehiculo()
        {

        }
    private:
        bool PesoExcedido(double peso);
        double CalcularIncremento(double peso);
    
};