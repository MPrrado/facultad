#include "Sistema.cpp"
#include <stdlib.h>
#include <time.h>
int main()
{
    srand(time(NULL));
    Fecha fechaAct;
    //generamos 10 vehiculos que su existencia no depende de nadie
    vector<string> patentes = {
        "AB123CD", "EF456GH", "IJ789KL", "MN012OP", "QR345ST",
        "UV678WX", "YZ901AB", "CD234EF", "GH567IJ", "KL890MN"
    };

    vector<Vehiculo*> listaVehiculos;

    Moto moto1(patentes[0],2018,5000,250);
    Moto moto2(patentes[1],2019,5500,300);
    Moto moto3(patentes[2],2020,6000,350);

    Auto auto1(patentes[3],2021,300,6500);
    Auto auto2(patentes[4],2022,400,7000);
    Auto auto3(patentes[5],2023,500,7500);

    // int anioModelo = 2015;
    // double pesoMax = 200;
    // double tarifa = 1500;
    // for(int i = 0; i < 10; i++)
    // {
    //     int random = rand()%10;
    //     Vehiculo miAuto(patentes[random],anioModelo,pesoMax,tarifa);
    //     listaVehiculos.push_back(miAuto);
    //     anioModelo+=1;
    //     pesoMax+=100;
    //     tarifa+=500;
    // }

    Sistema miSistema;
    miSistema.RegistrarEncomienda("Santa Fe 2800", "Crisostomo Alvarez 3000", 100, &moto1);
    miSistema.RegistrarEncomienda("Santa Fe 2900", "Crisostomo Alvarez 3100", 120, &moto2);
    miSistema.RegistrarEncomienda("Santa Fe 3000", "Crisostomo Alvarez 3200", 140, &moto3);
    miSistema.RegistrarEncomienda("Santa Fe 3100", "Crisostomo Alvarez 3300", 160, &auto1);
    miSistema.RegistrarEncomienda("Santa Fe 3200", "Crisostomo Alvarez 3400", 180, &auto2);
    miSistema.RegistrarEncomienda("Santa Fe 3300", "Crisostomo Alvarez 3500", 200, &auto3);

    //generamos las variables necesarias para la prueba
    // string origen = "santa fe ";
    // vector<string> nrosCalle = {"2800","2810'","2820","2830","2840","2850","2860","2870","2880","2890",};
    // string destino = "Las piedras ";
    // vector<string> nrosCalleDestino = {"2800","2810'","2820","2830","2840","2850","2860","2870","2880","2890",};

    //generamos 10 encomiendas
    // cout<<endl<<endl<<"GENERAMOS 10 ENCOMIENDAS...."<<endl<<endl;
    // for(int i = 0; i<10;i++)
    // {
    //     int random = rand()%10;
    //     miSistema.RegistrarEncomienda(origen+nrosCalle[random],destino+nrosCalleDestino[random],peso,listaVehiculos[random]);
    //     peso+=50;
    // }


    //SI SE QUIERE VER LO QUE SE GENERO DESCOMENTAR LAS 3 LINEAS SIGUIENTES
    // cout<<"Mostramos las encomiendas generadas (con la fecha de entrega 14/2/14 para poder mostrar lo que se genero simplemente)"<<endl;
    // Fecha fechaMuestra(14,2,14);
    // miSistema.ListarEntregas(fechaMuestra);

    vector<Encomienda*> listaEncomiendas = miSistema.GetListaEncomiendas();
    vector<Encomienda*> :: iterator i;
    i = listaEncomiendas.begin();
    for ( i ; i < listaEncomiendas.end(); i++)
    {
        (*i)->EscribirInfo();
    }
    
    cout<<endl;
    cout<<endl;
    cout<<endl;
    cout<<endl;
    cout<<"Entregamos las 6 encomiendas con fecha de entrega de 15-11-2024'"<<endl;
    
    Fecha fechaEntrega(15,11,2024);
    miSistema.CargarFechaEntrega(1,fechaEntrega);
    miSistema.CargarFechaEntrega(2,fechaEntrega);
    miSistema.CargarFechaEntrega(3,fechaEntrega);
    miSistema.CargarFechaEntrega(4,fechaEntrega);
    miSistema.CargarFechaEntrega(5,fechaEntrega);
    miSistema.CargarFechaEntrega(6,fechaEntrega);
    // for(int i=1; i<10; i+=2)
    // {
    //     miSistema.CargarFechaEntrega(i,fechaEntrega);
    // }

    miSistema.ListarEntregas(fechaEntrega);
    return 0;
}