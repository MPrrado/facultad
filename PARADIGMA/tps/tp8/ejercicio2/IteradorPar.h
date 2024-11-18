#ifndef ITERADORPAR_H_
#define ITERADORPAR_H_
#include "IteradorGeneralizacion.h"
class IteradorPar
{
    private:
        int posicionInicial;
        const Contenedor &C;
    public:
        IteradorPar(Contenedor &c):C(c), posicionInicial(0)
        {
        }
        ~IteradorPar()
        {   
        }

        bool HayElementos()
        {
            if(posicionInicial+2 <= C.MAX)
            {
                return true;
            }else
            {
                return false;
            }
        }
        void Avanzar()
        {
            if(HayElementos())
            {
                this->posicionInicial+=2;
            }else
            {
                cout<<"ERROR NO HAY MAS ELEMENTOS PARA ITERAR"<<endl;
            }
        }
        int GetDatoContenedor()
        {
            return C.arreglo[this->posicionInicial];
        }

};
#endif

