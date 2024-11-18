#ifndef ITERADORGENERALIZACION_H_
#define ITERADORGENERALIZACION_H_
#include "Contenedor.h"
class IteradorGeneralizacion
{
    protected:
        const Contenedor &contenedor;
        int posicionIterador;
    public:
        IteradorGeneralizacion(Contenedor &c, int posicion):contenedor(c), posicionIterador(posicion)
        {
        }
        virtual ~IteradorGeneralizacion()
        {
        }
        virtual bool HayElementos() = 0;
        virtual void Avanzar()=0;
        virtual int GetDatoContenedor()
        {
            return 1;
        }
};
#endif
