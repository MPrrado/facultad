#ifndef SERVICIO_H_
#define SERVICIO_H_
#include <iostream>
using namespace std;
class Servicio
{
    private:
        static int autoincremental;
        int codigo;
        string descripcion;
        double montoBase;
    public:
        Servicio(string descripcion, double montoBase);
        ~Servicio();
        double GetMontoBase();
        void ListarInfo();
};
#endif