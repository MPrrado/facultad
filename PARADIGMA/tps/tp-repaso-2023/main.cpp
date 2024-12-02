#include "EmpresaEvento.h"

int main()
{
    //creamos nuestra empresa de eventos
    EmpresaEvento miEmpresa("SANTA FE 2834");

    //creamos 5 servicios
    Servicio s1 ("AIRE ACONDICIONADO", 1000);
    Servicio s2 ("CATERING", 1500);
    Servicio s3 ("PILETAS", 2000);
    Servicio s4 ("BEBIDAS EXCLUSIVAS", 3000);
    Servicio s5 ("AFTER", 5000);

    // s1.ListarInfo();
    // s2.ListarInfo();
    // s3.ListarInfo();
    // s4.ListarInfo();
    // s5.ListarInfo();

    //damos de alta 5 eventos
    Fecha fecAct;

    vector<Servicio*> listaS1;
    vector<Servicio*> listaS2;
    vector<Servicio*> listaS3;
    vector<Servicio*> listaS4;
    vector<Servicio*> listaS5;

    listaS1.push_back(&s1);
    listaS1.push_back(&s2);
    listaS1.push_back(&s3);

    listaS2.push_back(&s1);
    listaS2.push_back(&s2);
    listaS2.push_back(&s3);
    listaS2.push_back(&s4);

    listaS3.push_back(&s1);
    listaS3.push_back(&s2);
    listaS3.push_back(&s3);
    listaS3.push_back(&s4);
    listaS3.push_back(&s5);
    
    listaS4.push_back(&s1);
    listaS4.push_back(&s2);
    listaS4.push_back(&s4);

    listaS5.push_back(&s1);
    listaS5.push_back(&s2);


    miEmpresa.AltaEvento("FIESTA 15",&fecAct,100,listaS1,50);
    miEmpresa.AltaEvento("CASAMIENTO",&fecAct,300,listaS2,200);
    miEmpresa.AltaEvento("DESPEDIDA",&fecAct,200,listaS3,50);
    miEmpresa.AltaEvento("REUNION BMW",&fecAct,30,listaS4,"BERLIN MOTORS", false);
    miEmpresa.AltaEvento("REUNION PATITAS CALLEJERAS",&fecAct,100,listaS5,"PATITAS CALLEJERAS", true);

    //mostramos el resumen del mes de diciembre de 2024
    miEmpresa.ResumenPorMes(12);

    


    return 0;
}