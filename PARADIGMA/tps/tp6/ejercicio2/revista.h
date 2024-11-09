#ifndef REVISTA_H_
#define REVISTA_H_
#include "lectura.h"
class Revista : public Lectura 
{
    private:
        static Fecha fecAct;
        int nroRevista;
        int volumen;
        string tematica;
    public:
        void MostrarInfo();
        string GetTematica();
        Revista(string titulo, int anioEdicion, double precioBase,int nroRevista, int volumen, string tematica);
        ~Revista()
        {
            
        };
    private:
        double CalcularPrecioFinal();
};
#endif 