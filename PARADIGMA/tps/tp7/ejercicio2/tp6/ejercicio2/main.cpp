#include "libreria.h"
#include "libro.h"
#include "revista.h"

int main()
{
    //generamos los articulos que tendra nuestra libreria
    Libro* libro1 = new Libro("EL Señor de los anillos", 2019,5000,"Editorial1", "Prado Matias", false);
    Libro* libro2 = new Libro("Harry Potter", 2022,15000,"Editorial2", "Prado Matias", true);
    Libro* libro3 = new Libro("IT", 1988,3600,"Editorial2", "Prado Matias", false);

    Revista* revista1 = new Revista("Ole",2023,6000,1,3,"Deportes");
    Revista* revista2 = new Revista("Ole",2023,7000,2,3,"Deportes");
    Revista* revista3 = new Revista("Ole",2023,8000,3,3,"Deportes");

    //creamos nuestra libreria
    Libreria miLibreria;

    //cargamos los articulos a nuestra libreria
    miLibreria.CargarArticulo(libro1);
    miLibreria.CargarArticulo(libro2);
    miLibreria.CargarArticulo(libro3);
    miLibreria.CargarArticulo(revista1);
    miLibreria.CargarArticulo(revista2);
    miLibreria.CargarArticulo(revista3);

    //generamos nuestra seleccion de articulos para crear una venta
    vector<Lectura*> listaArticulosVenta;
    listaArticulosVenta.push_back(revista1);    
    listaArticulosVenta.push_back(libro1);    
    listaArticulosVenta.push_back(libro2);
    
    //creamos nuestra venta
    miLibreria.CrearVenta(listaArticulosVenta);    

    //generamos la fecha de venta por la que queremos mostrar la informacion de la venta
    Fecha fecAct;

    miLibreria.ListarInfoVentaSegunFecha(&fecAct);


    libro1->~Libro();
    libro2->~Libro();
    libro3->~Libro();
    revista1->~Revista();
    revista2->~Revista();
    revista3->~Revista();
    return 0;
}