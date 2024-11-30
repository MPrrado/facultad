#ifndef MASCOTATRADICIONAL_H_
#define MASCOTATRADICIONAL_H_
#include "Mascota.h"
class MascotaTradicional : public Mascota
{
        double GetIncremento();
        public:
                MascotaTradicional(string nombre, Fecha* fecNac, string raza);
                ~MascotaTradicional();
};
#endif