#include "Vehiculo.h"

const int Vehiculo ::INCREMENTO = 25;
void Vehiculo ::EscribirInfo()
{
    cout << endl
         << endl
         << "----------- INFORMACION DEL VEHICULO -----------" << endl;
    cout << "PATENTE: " << this->patente << endl;
    cout << "ANIO MODELO: " << this->anioModelo << endl;
    cout << "PESO MAX: " << this->pesoMax << endl;
    cout << "TARIFA: " << this->tarifa << endl;
    cout << "---------------------------------------" << endl
         << endl;
}

bool Vehiculo ::PesoExcedido(double peso)
{
    return (this->pesoMax < peso);
}

double Vehiculo ::GetTarifa()
{
    return this->tarifa;
}

double Vehiculo ::CalcularIncremento(double peso)
{
    double montoIncremento = 0;
    if (PesoExcedido(peso))
    {
        montoIncremento = GetTarifa() * (INCREMENTO / 100);
    }
    return montoIncremento;
}

double Vehiculo ::calcularPrecioViaje(double peso)
{
    return (GetTarifa() + CalcularIncremento(peso));
}

Vehiculo ::Vehiculo()
{
    
}
Vehiculo ::Vehiculo(string patente, int anioModelo, double pesoMax, double tarifa)
{
    this->patente = patente;
    this->anioModelo = anioModelo;
    this->pesoMax = pesoMax;
    this->tarifa = tarifa;
}
