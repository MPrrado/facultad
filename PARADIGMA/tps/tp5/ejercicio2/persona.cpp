#include "persona.h"

string Persona :: GetNombre()
{
    return this->nombre;
}

string Persona :: GetBio()
{
    return this->biografia;
}

int Persona :: GetEdad()
{
    return this->edad;
}

Persona :: Persona(string nombre, string biografia, int edad)
{
    this->nombre = nombre;
    this->biografia = biografia;
    this->edad = edad;
}

Persona :: Persona()
{
    
}