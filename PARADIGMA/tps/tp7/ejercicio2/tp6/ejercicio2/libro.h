#ifndef LIBRO_H_
#define LIBRO_H_
#include "lectura.h"
class Libro : public Lectura
{
    private:
        string editorial;
        string autorPrincipal;
        bool bestSeller;
    public: 
        void MostrarInfo();
        bool EsBestSeller();
        Libro(string tituloLibro, int anioEdicionLibro, double precioBaseLibro, string editorialLibro, string autorPrincipalLibro, bool bestSeller);
        ~Libro()
        {
            
        };
    private:
        double CalcularPrecioFinal();
};
#endif 