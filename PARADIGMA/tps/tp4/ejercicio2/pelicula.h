#include <iostream>
#include <string>
using namespace std;

class Pelicula
{
    static int autonumerico;
    int codigo;
    string titulo;
    string director;
    bool estreno;
    float precioBase;
    char tipoPelicula; // N o I nacional o internacional
    
    public:
        void ListarInformacion();
        float CalcularCosto();
};