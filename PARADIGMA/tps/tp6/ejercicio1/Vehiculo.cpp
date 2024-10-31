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

// double Vehiculo ::CalcularPrecioViaje(double peso)
// {
//     return (GetTarifa() + CalcularIncremento(peso));
// }

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

//----------------------------------------- AUTO ---------------------------------------------- 

Auto :: Auto(string patente, int anioModelo, double pesoMax, double tarifa): Vehiculo(patente,anioModelo,pesoMax,tarifa)
{

}

Auto :: ~Auto()
{
    cout<<"Se desruye un auto"<<endl;
}

void Auto :: EscribirInfo()
{
    Vehiculo :: EscribirInfo();
    cout<<"Limite Minimo: "<<this->limiteMin<<endl;
}

double Auto :: CalcularPrecioViaje(double peso)
{
    if(peso < this->limiteMin)
    {
        return Vehiculo :: GetTarifa() * (1-BONUS)/100;
    }else
    {
        return Vehiculo :: GetTarifa() + Vehiculo :: CalcularIncremento(peso);
    }
}

//----------------------------------------- MOTO ----------------------------------------------

Moto :: Moto(string patente, int anio, double tarifa, double cilindradaN):Vehiculo(patente, anio, cilindradaN > 500? 160 : 80, tarifa),cilindrada (cilindradaN) 
{
}
Moto :: ~Moto()
{
    cout<<"Se desruye una moto"<<endl;
}

void Moto :: EscribirInfo()
{
    Vehiculo :: EscribirInfo();
    cout<<"Cilindrada Moto : "<<this->cilindrada<<endl;
}

double Moto :: CalcularPrecioViaje(double peso)
{
    return Vehiculo :: GetTarifa() + Vehiculo :: CalcularIncremento(peso);
}