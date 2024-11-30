#include "MascotaUNT.h"

int MascotaUNT:: autoincremental = 1;

MascotaUNT::MascotaUNT(string direccion, vector<Cliente*> clientes)
{
    this->codigo = autoincremental;
    this->direccion = direccion;
    this->listaClientes = clientes;
    autoincremental++;
}

MascotaUNT::~MascotaUNT()
{
}

void MascotaUNT:: ListarResumen(short mes, short anio)
{
    double monto = 0;
    this->i = this->listaClientes.begin();
    cout<<"--------------------- RESUMEN RECAUDADO ---------------------"<<endl;
    for (this->i; this->i < this->listaClientes.end(); this->i++)
    {
        cout<<"-------------------------------------------------------------"<<endl;
        cout<<"Codigo Cliente: "<<(*i)->GetCodigo()<<endl;
        cout<<"Monto Recaudado Del Cliente: $"<< (*i)->GetMonto(mes,anio)<<endl;
        monto += (*i)->GetMonto(mes,anio);
        cout<<"-------------------------------------------------------------"<<endl;
    }
    cout<<endl<<"MONTO TOTAL RECAUDADO: $"<<monto<<endl;
    
}
