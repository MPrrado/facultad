#ifndef ITERADORPAR_H_
#define ITERADORPAR_H_
#include "IteradorGeneralizacion.h"
template <class X>
class IteradorPar : public IteradorGeneralizacion<X>
{
    public:
        IteradorPar(Contenedor<X> &c);
        ~IteradorPar();
        bool HayElementos();
        void Avanzar();

};
template <class X>
IteradorPar<X>:: IteradorPar(Contenedor<X> &c):IteradorGeneralizacion<X>(c,0)
{}

template <class X>
IteradorPar<X>:: ~IteradorPar()
{

}
template <class X>
bool IteradorPar<X> :: HayElementos()
{
    if(this->posicionIterador <= this->contenedor.MAX)
    {
        return true;
    }else
    {
        return false;
    }
}

template <class X>
void IteradorPar<X> :: Avanzar()
{
    if(HayElementos())
    {
        this->posicionIterador+=2;
    }else
    {
        cout<<"ERROR NO HAY MAS ELEMENTOS PARA ITERAR"<<endl;
    }
}
#endif

