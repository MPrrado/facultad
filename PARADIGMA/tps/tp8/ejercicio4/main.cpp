#include "MascotaUNT.h"
#include "MascotaExotica.h"
#include "MascotaTradicional.h"

int main()
{
    //generamos las fechas nacimientos de las mascotas
    Fecha fn1(14,2,2003);
    Fecha fn2(2,3,1982);
    Fecha fn3(20,11,1981);
    Fecha fn4(19,8,2007);
    Fecha fn5(25,11,2015);

    //generamos 5 mascotas
    MascotaTradicional m1("Perro1",&fn1,"Caniche");
    MascotaTradicional m2("Perro2",&fn2,"Pastor Aleman");
    MascotaTradicional m3("Gato1",&fn3,"Arabe");
    MascotaExotica m4("Loro",&fn4,"Africano", "loro multicolor");
    MascotaExotica m5("Tigre",&fn5,"Bengala", "del maldito Iron Myke");

    //Armamos la lista de mascotas para cada cliente
    vector<Mascota*> mascotasCliente1;
    mascotasCliente1.push_back(&m1);

    vector<Mascota*> mascotasCliente2;
    mascotasCliente2.push_back(&m2);

    vector<Mascota*> mascotasCliente3;
    mascotasCliente3.push_back(&m3);
    mascotasCliente3.push_back(&m4);
    mascotasCliente3.push_back(&m5);

    //generamos 3 clientes
    Cliente c1("Pepe", "pepe@gmail.com", mascotasCliente1);
    Cliente c2("Matias", "Matias@gmail.com", mascotasCliente2);
    Cliente c3("Iron Myke", "IronMyke@gmail.com", mascotasCliente3);

    //armamos la lista de clientes
    vector<Cliente*> listaClientes;
    listaClientes.push_back(&c1);
    listaClientes.push_back(&c2);
    listaClientes.push_back(&c3);
    //creamos nuestra sucursal
    MascotaUNT sucursal("Santa Fe 2832",listaClientes);

    //testeo de muestra de informacion de mascota

    // m1.ListarInformacion();
    // m2.ListarInformacion();
    // m3.ListarInformacion();
    // m4.ListarInformacion();
    // m5.ListarInformacion();

    //creamos controles para las mascotas
    Fecha fecAct;
    Fecha fecProxControl(8,12,2024);
    Fecha fecProxControlMenor5dias(30,11,2024);
    m1.AltaControl(&fecAct,"control-m1", 5000, &fecProxControl);
    m2.AltaControl(&fecAct,"control-m2", 6000, &fecProxControl);
    m3.AltaControl(&fecAct,"control-m3", 7000, &fecProxControl);
    m4.AltaControl(&fecAct,"control-m4", 8000, &fecProxControlMenor5dias);
    m5.AltaControl(&fecAct,"control-m5", 9000, &fecProxControlMenor5dias);

    // m1.ListarInformacion();
    // m2.ListarInformacion();
    // m3.ListarInformacion();
    // m4.ListarInformacion();
    // m5.ListarInformacion();

    c1.ListarMascotasProximaAControl();
    c2.ListarMascotasProximaAControl();
    c3.ListarMascotasProximaAControl();

    cout<<endl<<"MONTO TOTAL RECAUDADO EN 11/2024 POR EL CLIENTE: "<<c3.GetNombre()<<endl<<"Monto: $"<<c3.GetMonto(11,2024)<<endl;
    cout<<endl<<"MONTO TOTAL RECAUDADO EN 11/2024 POR EL CLIENTE: "<<c2.GetNombre()<<endl<<"Monto: $"<<c2.GetMonto(11,2024)<<endl;
    cout<<endl<<"MONTO TOTAL RECAUDADO EN 11/2024 POR EL CLIENTE: "<<c1.GetNombre()<<endl<<"Monto: $"<<c1.GetMonto(11,2024)<<endl<<endl;

    sucursal.ListarResumen(11,2024);
    return 0;
}
