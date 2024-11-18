#ifndef ITERADORINVERSO_H_
#define ITERADORINVERSO_H_
#include "IteradorGeneralizacion.h"
class IteradorInverso : public IteradorGeneralizacion
{
    public:
        IteradorInverso(Contenedor &c);
        ~IteradorInverso(); 
        bool HayElementos();
        void Avanzar();
        int GetDatoContenedor();
};
#endif

