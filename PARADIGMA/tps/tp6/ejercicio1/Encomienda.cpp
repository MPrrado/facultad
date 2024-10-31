#include "Encomienda.h"
int Encomienda ::autonumerico = 0;

void Encomienda ::EscribirInfo()
{
    cout<<endl<<endl<<"---------------- INFORMACION ENCOMIENDA----------------"<<endl;
    cout<<"Codigo Encomienda: "<<this->codigoEncomienda<<endl;
    cout<<"Direccion De Origen: "<<this->dirOrigen<<endl;
    cout<<"Direccion De Destino: "<<this->dirDestino<<endl;
    cout<<"Fecha De Ingreso: "<<this->fechaIngreso->toString()<<endl;
    if(this->entregado)
    {
        cout<<"ESTADO: entregado"<<endl;
    }else
    {
        cout<<"ESTADO: NO entregado"<<endl;
    }
    cout<<"Peso Encomienda: "<<this->pesoEncomienda<<" kg"<<endl;
    cout<<"------------------- VEHICULO A CARGO -------------------";
    this->vehiculoAcargo->EscribirInfo();
    cout<<"-----------------------------------------------"<<endl;
}

void Encomienda ::SetFechaEntrega(Fecha fecha)
{
    this->fechaEntrega = &fecha;
    this->entregado = true;
}

Fecha Encomienda ::GetFechaEntrega()
{
    return *this->fechaEntrega;
}

int Encomienda ::GetCodigo()
{
    return this->codigoEncomienda;
}

double Encomienda ::GetPeso()
{
    return this->pesoEncomienda;
}
double Encomienda ::CalcularPrecioEncomienda()
{
    double peso = GetPeso();
    double precio = this->vehiculoAcargo->CalcularPrecioViaje(peso);
    return precio;
}

Encomienda ::Encomienda()
{
    autonumerico++;
}
Encomienda ::Encomienda(string dirOrigen, string dirDestino, double pesoEncomienda, Vehiculo* vehiculoAcargo)
{
    Fecha *fechaIngreso = new Fecha();
    autonumerico++;
    this->codigoEncomienda = autonumerico;
    this->dirOrigen = dirOrigen;
    this->dirDestino = dirDestino;
    this->fechaIngreso = fechaIngreso;
    this->fechaEntrega = nullptr;
    this->entregado = false;
    this->pesoEncomienda = pesoEncomienda;
    this->vehiculoAcargo = vehiculoAcargo;
}