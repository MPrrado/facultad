#ifndef ITERADORINVERSO_H_
#define ITERADORINVERSO_H_
#include "IteradorGeneralizacion.h"
template <class X>
class IteradorInverso : public IteradorGeneralizacion<X>
{
    public:
        IteradorInverso(Contenedor<X> &c);
        ~IteradorInverso(); 
        bool HayElementos();
        void Avanzar();
};

template <class X>
IteradorInverso<X> :: IteradorInverso(Contenedor<X> &c): IteradorGeneralizacion<X>(c, c.capacidad()-1)
{
}
template <class X>
IteradorInverso<X> :: ~IteradorInverso()
{   
}
template <class X>
bool IteradorInverso<X> :: HayElementos()
{
    return this->posicionIterador >= 0;
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

#endif

