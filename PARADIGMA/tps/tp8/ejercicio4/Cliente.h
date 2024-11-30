#ifndef CLIENTE_H_
#define CLIENTE_H_
#include <iostream>
#include <vector>
#include "Mascota.h"
using namespace std;
class Cliente 
{
    private:
        static int autoincremental;
        int codigo;
        string nombre;
        string mail;
        vector<Mascota*> mascotas;
        vector<Mascota*> :: iterator i;
    public:
        Cliente(string nombre, string mail, vector<Mascota*> mascotasACargo);
        ~Cliente();
        double GetMonto(short mes, short anio);
        int GetCodigo();
        void ListarMascotasProximaAControl();
        void AgregarMascota(Mascota* mascota);
        string GetNombre();

};
#endif