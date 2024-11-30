#ifndef MASCOTAUNT_H_
#define MASCOTAUNT_H_
#include <iostream>
#include "Cliente.h"
#include <vector>
using namespace std;

class MascotaUNT
{
    private:
        static int autoincremental;
        int codigo;
        string direccion;
        vector<Cliente*> listaClientes;
        vector<Cliente*> :: iterator i;
    public:
        MascotaUNT(string direccion, vector<Cliente*> clientes);
        ~MascotaUNT();
        void ListarResumen(short mes, short anio);
};


#endif