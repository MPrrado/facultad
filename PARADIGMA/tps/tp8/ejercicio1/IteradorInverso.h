#ifndef ITERADORINVERSO_H_
#define ITERADORINVERSO_H_
#include "Contenedor.h"
class IteradorInverso
{
    private:
        int posicionFinal;
        const Contenedor &C;
    public:
        IteradorInverso(Contenedor &c):C(c)
        {
            this->posicionFinal = c.capacidad()-1;
        }
        ~IteradorInverso()
        {
            
        }

        bool HayElementos()
        {
            return posicionFinal >=0;
        }
        void Retroceder()
        {
            if(HayElementos())
            {
                this->posicionFinal--;
            }else
            {
                cout<<"ERROR NO HAY MAS ELEMENTOS PARA ITERAR"<<endl;
            }
        }
        int GetDatoContenedor()
        {
            return C.arreglo[this->posicionFinal];
        }

};
#endif

