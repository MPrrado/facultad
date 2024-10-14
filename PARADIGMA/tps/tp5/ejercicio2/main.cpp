#include "pelicula.cpp"

int main()
{
    Persona directorMiPeli("Matias Prado", "cantante de los Palmeras", 21);
    Fecha fechaEstrenoMiPeli(13, 10, 2023);
    Pelicula miPeli(431, "Un descubrimiento descubridor", directorMiPeli, fechaEstrenoMiPeli, 35, Internacional);
    cout << "PROGRAMA PRUEBA DE PELICULA" << endl;
    miPeli.ListarInformacion();
    cout << "COSTO DE LA PELICULA: $" << miPeli.CalcularCosto() <<"usd"<< endl;
    if (miPeli.EsEstreno())
    {
        cout << "LA PELICULA ES UN ESTRENO" << endl;
    }
    else
    {
        cout << "LA PELICULA NO ES UN ESTRENO" << endl;
    }

    return 0;
}