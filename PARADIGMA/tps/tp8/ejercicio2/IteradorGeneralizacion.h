#ifndef ITERADORGENERALIZACION_H_
#define ITERADORGENERALIZACION_H_
#include "Contenedor.h"
template <class X>
class IteradorGeneralizacion
{
    protected:
        const Contenedor<X> &contenedor;
        int posicionIterador;
    public:
        IteradorGeneralizacion(Contenedor<X> &c, int posicion):contenedor(c), posicionIterador(posicion)
        {
        }
        virtual ~IteradorGeneralizacion()
        {
        }
        virtual bool HayElementos() = 0;
        virtual void Avanzar()=0;
        virtual X GetDatoContenedor();
};

template <class X>
X IteradorGeneralizacion<X> ::  GetDatoContenedor()
{
    return this->contenedor.arreglo[posicionIterador];
}
#endif
