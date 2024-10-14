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

    vector<Vehiculo> listaVehiculos;

    int anioModelo = 2015;
    double pesoMax = 200;
    double tarifa = 1500;
    for(int i = 0; i < 10; i++)
    {
        int random = rand()%10;
        Vehiculo miAuto(patentes[random],anioModelo,pesoMax,tarifa);
        listaVehiculos.push_back(miAuto);
        anioModelo+=1;
        pesoMax+=100;
        tarifa+=500;
    }

    Sistema miSistema;
    double peso = 100;

    //generamos las variables necesarias para la prueba
    string origen = "santa fe ";
    vector<string> nrosCalle = {"2800","2810'","2820","2830","2840","2850","2860","2870","2880","2890",};
    string destino = "Las piedras ";
    vector<string> nrosCalleDestino = {"2800","2810'","2820","2830","2840","2850","2860","2870","2880","2890",};

    //generamos 10 encomiendas
    cout<<endl<<endl<<"GENERAMOS 10 ENCOMIENDAS...."<<endl<<endl;
    for(int i = 0; i<10;i++)
    {
        int random = rand()%10;
        miSistema.RegistrarEncomienda(origen+nrosCalle[random],destino+nrosCalleDestino[random],peso,listaVehiculos[random]);
        peso+=50;
    }


    //SI SE QUIERE VER LO QUE SE GENERO DESCOMENTAR LAS 3 LINEAS SIGUIENTES
    // cout<<"Mostramos las encomiendas generadas (con la fecha de entrega 14/2/14 para poder mostrar lo que se genero simplemente)"<<endl;
    // Fecha fechaMuestra(14,2,14);
    // miSistema.ListarEntregas(fechaMuestra);

    cout<<"Entregamos todos las Encomiendas cuyo codigo sea impar y colocamos la fecha de entrega '20/10/2024'"<<endl;
    
    Fecha fechaEntrega(20,10,2024);
    for(int i=1; i<10; i+=2)
    {
        miSistema.CargarFechaEntrega(i,fechaEntrega);
    }

    miSistema.ListarEntregas(fechaEntrega);
    return 0;
}