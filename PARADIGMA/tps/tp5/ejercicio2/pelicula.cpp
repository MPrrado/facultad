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
    GetBiografiaDirector();
    if(EsEstreno())
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
void Pelicula :: GetBiografiaDirector()
{
    cout<<"-------------- DATOS DEL DIRECTOR --------------"<<endl;
    cout<<"Nombre: "<<this->director.GetNombre()<<endl;
    cout<<"Biografia: "<<this->director.GetBio()<<endl;
    cout<<"Edad: "<<this->director.GetEdad()<<endl;
}

bool Pelicula :: EsEstreno()
{
    Fecha fecAct; // esta variable se genera con el constructor sin parametros que me genera la fecha actual
    return (((fecAct - this->estreno) < 1));
} 
float Pelicula :: CalcularCosto()
{  
    float costo = this->precioBase;
    if(this->tipoPelicula == (TipoPelicula) Internacional)
    {
        costo *=1.30;
    }else
    {
        if(!EsEstreno())
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
Pelicula :: Pelicula(int codigo, string titulo, Persona director, Fecha estreno, float precioBase, TipoPelicula tipoPelicula)
{
    autonumerico++;
    this->codigo = codigo;
    this->titulo = titulo;
    this->director = director;
    this->estreno = estreno;
    this->precioBase = precioBase;
    this->tipoPelicula = tipoPelicula;
}

Pelicula :: Pelicula(const Pelicula &oldPeli) //constructor copia!!!!!!!!
{
    this->codigo = oldPeli.codigo;
    this->titulo = oldPeli.titulo;
    this->director = oldPeli.director;
    this->estreno = oldPeli.estreno;
    this->precioBase = oldPeli.precioBase;
    this->tipoPelicula = oldPeli.tipoPelicula;    
}

