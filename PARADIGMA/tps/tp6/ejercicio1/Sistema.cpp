#include "Sistema.h"


void Sistema ::RegistrarEncomienda(string origen, string destino, double peso, Vehiculo *autoAcargo)
{
    // Fecha* fechaIngresoEncomienda = new Fecha();
    Encomienda* miEncomienda = new Encomienda(origen,destino,peso, autoAcargo);
    listaEncomiendas.push_back(miEncomienda);
}



vector<Encomienda*> Sistema ::GetListaEncomiendas()
{
    return listaEncomiendas;
}

void Sistema ::CargarFechaEntrega(int codigoEncomienda, Fecha fechaEntrega)
{
    vector<Encomienda*> ::iterator i; // asi declaro un iterador (que no es mas que basicamente un puntero que se movera a lo largo de mi lista)
    i = listaEncomiendas.begin(); //asi indico que mi iterador comience al principio de la lista que cree a traves de la libreria vector
    for (i; i!=listaEncomiendas.end(); i++)
    {
        if((*i)->GetCodigo() == codigoEncomienda)
        {
            (*i)->SetFechaEntrega(fechaEntrega);
        }
    }
}

void Sistema ::ListarEntregas(Fecha fecha)
{
    double recaudacion = 0;
    vector<Encomienda*> ::iterator i; // asi declaro un iterador (que no es mas que basicamente un puntero que se movera a lo largo de mi lista)
    i = listaEncomiendas.begin(); //asi indico que mi iterador comience al principio de la lista que cree a traves de la libreria vector
    for (i; i!=listaEncomiendas.end(); i++)
    {
        if((*i)->GetFechaEntrega().toString() == fecha.toString())
        {
            recaudacion+=(*i)->CalcularPrecioEncomienda();
            (*i)->EscribirInfo();
        }
    }
    cout<<"RECAUDACION TOTAL: $"<<recaudacion<<endl<<endl<<endl;
}

Sistema ::~Sistema()
{

}