#include "cuenta.h"

bool Cuenta::Depositar(double monto)
{
    if (monto > 0)
    {
        this->saldo += monto;
        return true;
    }
    else
    {
        return false;
    }
};

bool Cuenta::Extraer(double monto)
{
    if (monto <= this->saldo && monto >= 0)  
    {
        this->saldo -= monto;
        return true;
    }
    else
    {
        return false;
    }
};

double Cuenta::GetSaldo()
{
    return this->saldo;
};

void Cuenta::MostrarInformacion()
{
    cout <<"----- INFORMACION CUENTA -----"<<endl;
    cout <<"Numero de cuenta: "<<this->numero<<endl;
    cout <<"DNI titular: "<<this->dniTitular<<endl;
    cout <<"Saldo cuenta: $ "<<this->saldo<<endl;
};