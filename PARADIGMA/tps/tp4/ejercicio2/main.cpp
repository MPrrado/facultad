#include "pelicula.cpp"
#include <iostream>

int main ()
{
    Pelicula miPeli; //pelicula con codigo = 000;
    miPeli.ListarInformacion();

    Pelicula miPeli2(1,"Rocky I","Justin Lee", true, 4500.50, (TipoPelicula) Internacional);
    miPeli2.ListarInformacion();

    Pelicula miPeli3(miPeli2);
    miPeli3.ListarInformacion();
    return 0;
}