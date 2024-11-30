#include <iostream>
#include "Tienda.h"
using namespace std;

int main() {
	Tienda T1("Paradigmas", "Av. Independencia 1800");

	// CREAR 3 PRODUCTOS

	Producto p1(1,"Pepsi 2L", 1500);
	Producto p2(2,"Papas Lay", 2500);
	Producto p3(3,"Queso", 3000);
	vector<Producto*> listaProductos1;
	listaProductos1.push_back(&p1);
	// cout<<p1.resumenProducto()<<endl;
	// cout<<p2.resumenProducto()<<endl;
	// cout<<p3.resumenProducto()<<endl;

	// GENERAR 1 COMPRA DE CONTADO CON FECHA 22/09/2024 CON 1 PRODUCTO DE LA TIENDA

	Fecha fechaCompra1(22,9,2024);
	T1.generarCompra(listaProductos1,&fechaCompra1);


	// GENERAR 1 COMPRA EN 3 CUOTAS CON FECHA 06/08/2024 QUE CONTENGA 3 PRODUCTOS DE LA TIENDA

	vector<Producto*> listaProductos2;
	listaProductos2.push_back(&p1);
	listaProductos2.push_back(&p2);
	listaProductos2.push_back(&p3);
	Fecha fechaCompra2(6,8,2024);
	T1.generarCompra(listaProductos2, &fechaCompra2);

	// GENERAR 1 COMPRA EN 6 CUOTAS CON FECHA 15/09/2024 QUE CONTENGA 2 PRODUCTOS DE LA TIENDA

	vector<Producto*> listaProductos3;
	listaProductos3.push_back(&p1);
	listaProductos3.push_back(&p2);
	listaProductos3.push_back(&p3);
	Fecha fechaCompra3(15,9,2024);
	T1.generarCompra(listaProductos3, &fechaCompra3);

	T1.resumenCompras(8,2024);

	return 0;

}
