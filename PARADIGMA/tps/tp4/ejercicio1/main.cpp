#include <iostream>
#include "cuenta.cpp"
using namespace std;


const double TRANSFERENCIA = 5000;
bool Transferir(Cuenta &c1, Cuenta &c2);
int main()
{
    //declaramos nuestras constantes para mejor manejo
    const int NUMERO = 12345;
    const long int DNI = 44658689;
    const double SALDO = 10000.5;
    //creamos un objeto cuenta;

    Cuenta miCuenta = Cuenta(NUMERO,DNI,SALDO);
    Cuenta otraCuenta = Cuenta(NUMERO+111,DNI+111,SALDO+20000);
    miCuenta.MostrarInformacion(); //mostramos como se creo el objeto

    //hacemos un deposito
    miCuenta.Depositar(SALDO);
    miCuenta.MostrarInformacion(); //mostramos como queda la cuenta

    miCuenta.Extraer(TRANSFERENCIA); //hacemos una extraccion de 5000;
    miCuenta.MostrarInformacion(); //mostramos como queda la cuenta
    cout<<endl;
    cout<<endl;
    cout<<endl;

    //a continuacion mostramos la informacion de ambas cuentas
    cout << "---------- CUENTA 1 ----------"<<endl;
    miCuenta.MostrarInformacion();
    cout << "---------- CUENTA 2 ----------"<<endl;
    otraCuenta.MostrarInformacion();
    if(Transferir(miCuenta, otraCuenta))
    {
        cout << "TRANFERENCIA REALIZADA CON EXITO"<<endl;
        cout<<endl;
        cout<<endl;
        cout<<endl;
        cout<<endl;
        cout << "---------- CUENTA 1 ----------"<<endl;
        miCuenta.MostrarInformacion();
        cout << "---------- CUENTA 2 ----------"<<endl;
        otraCuenta.MostrarInformacion();
    }else
    {
        cout << "TRANFERENCIA ERRONEA"<<endl;

    }
    return 0;
}

bool Transferir(Cuenta &c1, Cuenta &c2)
{
    if(c1.Extraer(TRANSFERENCIA))
    {
        return c2.Depositar(TRANSFERENCIA);
    }else
    {
        return false;
    }
}
