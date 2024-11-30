#include "Cliente.h"

int Cliente :: autoincremental = 1;

Cliente :: Cliente(string nombre, string mail, vector<Mascota*> mascotasACargo)
{
    this->codigo = autoincremental;
    this->nombre = nombre;
    this->mail = mail;
    this->mascotas = mascotasACargo;
    autoincremental++;
}

Cliente:: ~Cliente()
{

}

double Cliente:: GetMonto(short mes, short anio)
{
    double monto = 0;
    this->i = this->mascotas.begin();
    for (this->i; this->i < this->mascotas.end(); this->i++)
    {
        monto += (*i)->GetMonto(mes, anio);
    }
    return monto;
}

int Cliente:: GetCodigo()
{
    return this->codigo;
}

void Cliente:: ListarMascotasProximaAControl()
{
    this->i = this->mascotas.begin();
    cout<<endl<<"CLIENTE: "<<this->nombre<<endl;
    cout<<"----------------- MASCOTAS CON CONTROL PRONTO -----------------"<<endl;
    for (this->i ; this->i < this->mascotas.end(); this->i++)
    {
        if((*i)->TieneControlPronto())
        {
            cout<<"Nombre: "<<(*i)->GetNombre()<<endl;
        }
    }
    
}

string Cliente:: GetNombre()
{
    return this->nombre;
}