#include <iostream>
#include "persona.cpp"
#include "Fecha.cpp"
using namespace std;

enum TipoPelicula
{
    Nacional = 'N',
    Internacional = 'I'
};
class Pelicula
{
    static int autonumerico;
    int codigo;
    string titulo;
    Persona director;
    Fecha estreno;
    float precioBase;
    TipoPelicula tipoPelicula; // N o I nacional o internacional
    
    public:
        Pelicula();
        Pelicula(int codigo, string titulo, Persona director, Fecha estreno, float precioBase, TipoPelicula tipoPelicula);
        Pelicula(const Pelicula &); //siempre tiene que ser const? por qué?
        void ListarInformacion();
        void GetBiografiaDirector();
        bool EsEstreno();
        float CalcularCosto();
};