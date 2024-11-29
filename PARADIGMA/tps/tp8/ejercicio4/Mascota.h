#ifndef MASCOTA_H_
#define MASCOTA_H_
#include <iostream>
using namespace std;
#include "Fecha.h"
#include <vector>
#include "Control.h"
class Mascota
{
    private:   
        string nombre;
        Fecha* fecNac;
        string raza;
        vector<Control*> controles;
        vector<Control*> :: iterator i;
    public:
        Mascota(string nombre, Fecha* fecNac, string raza);
        ~Mascota();
        void AltaControl(Fecha* fecha, string descripcion, double monto,Fecha* fecProxContol);
        double GetMonto(short mes, short anio);
        bool TieneControlPronto();
        void ListarInformacion();
        string GetNombre();

    protected:
        virtual double GetIncremento() = 0; //mi metodo virtual puro para obtener mi clase abstracta
};
#endif