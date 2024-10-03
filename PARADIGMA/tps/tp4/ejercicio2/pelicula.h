#include <iostream>
#include <string>
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
    string director;
    bool estreno;
    float precioBase;
    TipoPelicula tipoPelicula; // N o I nacional o internacional
    
    public:
        void ListarInformacion();
        float CalcularCosto();
};