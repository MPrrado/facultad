#include <iostream>
using namespace std;

class Persona
{
    string nombre;
    string biografia;
    int edad;
    public:
        string GetNombre();
        string GetBio();
        int GetEdad();
        Persona();
        Persona(string nombre, string biografia, int edad);
        ~Persona()
        {

        }
};
