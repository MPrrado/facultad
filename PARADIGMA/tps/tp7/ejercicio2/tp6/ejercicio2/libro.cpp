#include "libro.h"

void Libro :: MostrarInfo()
{
    Lectura :: MostrarInfo();
    cout<<"Editorial : "<<this->editorial<<endl;
    cout<<"Autor Principal : "<<this->autorPrincipal<<endl;
    if(this->EsBestSeller())
    {
        cout<<"Libro BEST SELLER"<<endl;
    }
}

bool Libro :: EsBestSeller()
{
    return this->bestSeller;
}

double Libro :: CalcularPrecioFinal()
{
    double precio = this->precioBase;
    if(this->EsBestSeller())
    {
        precio *= 1.10;
    }
    return precio * 1.21;
}

Libro :: Libro(string tituloLibro, int anioEdicionLibro, double precioBaseLibro, string editorialLibro, string autorPrincipalLibro, bool bestSellerLibro) : Lectura (tituloLibro, anioEdicionLibro, precioBaseLibro), editorial(editorialLibro), autorPrincipal(autorPrincipalLibro), bestSeller(bestSellerLibro)
{

}



