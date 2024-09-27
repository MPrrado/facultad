#include <iostream>
using namespace std;

class Cuenta
{
    int numero;
    long int dniTitular;
    double saldo;

    public:
        Cuenta(int numero,  long int dniTitular, double saldo)
        {
            this->numero = numero;
            this->dniTitular = dniTitular;
            this->saldo = saldo;
        }
        bool Depositar(double monto);
        bool Extraer(double monto);
        double GetSaldo();
        void MostrarInformacion();

};