#include "pelicula.h"

void Pelicula :: ListarInformacion()
{
    cout << "INFORMACION PELICULA: "<<endl;
    cout << endl;
    cout << "codigo pelicula: "<<this->codigo<<endl;
    cout << "titulo: "<<this->titulo<<endl;
    cout << "director: "<<this->director<<endl;
    if(this->estreno)
    {
        cout <<"la pelicula es un estreno"<<endl;
    }
    if(this->tipoPelicula == 'N')
    {
        
        cout <<"la pelicula es nacional"<<endl;
    }else if(this->tipoPelicula == 'I')
    {

        cout <<"la pelicula es internacional"<<endl;
    }


}