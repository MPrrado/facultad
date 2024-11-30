#ifndef MASCOTAEXOTICA_H_
#define MASCOTAEXOTICA_H_
#include "Mascota.h"
class MascotaExotica : public Mascota
{
    string descripcion;
    double GetIncremento();
    public:
        void ListarInformacion();
        MascotaExotica(string nombre, Fecha* fecNac, string raza,string descripcion);
        ~MascotaExotica();
};
#endif