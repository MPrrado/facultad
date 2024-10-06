#include "pelicula.h"
int Pelicula::autonumerico = 0;

void Pelicula :: ListarInformacion()
{
    cout<<endl;
    cout<<endl;
    cout << "----------INFORMACION PELICULA: ----------"<<endl;
    cout<<endl;
    cout << "AUTONUMERICO: "<<autonumerico<<endl;
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
    }else if(this->tipoPelicula == (TipoPelicula) Internacional)
    {

        cout <<"la pelicula es internacional"<<endl;
    }
}

float Pelicula :: CalcularCosto()
{
    float costo = 0;
    if(this->tipoPelicula == (TipoPelicula) Internacional)
    {
        costo *=1.30;
    }else
    {
        if(this->estreno == false)
        {
            costo*=0.8;
        }
    }
    return costo;
}

Pelicula :: Pelicula()
{
    autonumerico++;
    this->codigo = 000;
}
Pelicula :: Pelicula(int codigo, string titulo, string director, bool estreno, float precioBase, TipoPelicula tipoPelicula)
{
    autonumerico++;
    this->codigo = codigo;
    this->titulo = titulo;
    this->director = director;
    this->estreno = estreno;
    this->precioBase = precioBase;
    this->tipoPelicula = tipoPelicula;
}

Pelicula :: Pelicula(const Pelicula &oldPeli)
{
    // Pelicula :: Pelicula(oldPeli.codigo, oldPeli.titulo, oldPeli.director, oldPeli.estreno, oldPeli.precioBase, oldPeli.tipoPelicula);
    this->codigo = oldPeli.codigo;
    this->titulo = oldPeli.titulo;
    this->director = oldPeli.director;
    this->estreno = oldPeli.estreno;
    this->precioBase = oldPeli.precioBase;
    this->tipoPelicula = oldPeli.tipoPelicula;    

}

