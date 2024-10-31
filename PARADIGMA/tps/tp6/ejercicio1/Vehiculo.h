#include <iostream>
using namespace std;
class Vehiculo
{
protected:
    string patente;
    int anioModelo;
    double pesoMax;
    static const int INCREMENTO;
    double tarifa;

public:
    virtual void EscribirInfo();
    double GetTarifa();
    virtual double CalcularPrecioViaje(double peso) = 0;
    Vehiculo();
    Vehiculo(string patente, int anioModelo, double pesoMax, double tarifa);
    virtual ~Vehiculo()
    {
    }

private:
    bool PesoExcedido(double peso);

protected:
    double CalcularIncremento(double peso);
};

class Auto : public Vehiculo
{
    double limiteMin;
    static const int BONUS = 10;

public:
    void EscribirInfo();
    double CalcularPrecioViaje(double peso);
    Auto(string patente, int anioModelo, double pesoMax, double tarifa);
    ~Auto();
};

class Moto : public Vehiculo
{
    double cilindrada;

public:
    void EscribirInfo();
    double CalcularPrecioViaje(double peso);
    Moto(string patente, int anio, double tarifa, double cilindrada);
    ~Moto();
};