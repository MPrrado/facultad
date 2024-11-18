#ifndef ITERADORINVERSO_H_
#define ITERADORINVERSO_H_
#include "IteradorGeneralizacion.h"
template <class X>
class IteradorInverso : public IteradorGeneralizacion <class X>
{
    public:
        IteradorInverso(Contenedor<X> &c);
        ~IteradorInverso(); 
        bool HayElementos();
        void Avanzar();
        X GetDatoContenedor();
};

template <class X>
IteradorInverso<X> :: IteradorInverso(Contenedor<X> &c): IteradorGeneralizacion(c, c.capacidad()-1)
{
}
template <class X>
IteradorInverso<X> :: ~IteradorInverso()
{   
}
template <class X>
bool IteradorInverso<X> :: HayElementos()
{
    return posicionIterador >= 0;
}
template <class X>
void IteradorInverso<X> :: Avanzar()
{
    if(HayElementos())
    {
        this->posicionIterador--;
    }else
    {
        cout<<"ERROR NO HAY MAS ELEMENTOS PARA ITERAR"<<endl;
    }
}
template <class X>
X IteradorInverso<X> :: GetDatoContenedor()
{
        return contenedor.arreglo[this->posicionIterador];
}

#endif

