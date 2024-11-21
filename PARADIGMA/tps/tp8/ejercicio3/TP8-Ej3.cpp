#include <iostream>
#include "Tienda.h"
using namespace std;

int main() {
	Tienda T1("Paradigmas", "Av. Independencia 1800");

	// CREAR 3 PRODUCTOS

	Producto p1(1,"Pepsi 2L", 1500);
	Producto p2(1,"Papas Lay", 2500);
	Producto p3(1,"Queso", 3000);
	vector<Producto*> listaProductos;
	listaProductos.push_back(&p1);
	listaProductos.push_back(&p2);
	listaProductos.push_back(&p3);
	p1.resumenProducto();
	p2.resumenProducto();
	p3.resumenProducto();
	// GENERAR 1 COMPRA DE CONTADO CON FECHA 22/09/2024 CON 1 PRODUCTO DE LA TIENDA

	// GENERAR 1 COMPRA EN 3 CUOTAS CON FECHA 06/08/2024 QUE CONTENGA 3 PRODUCTOS DE LA TIENDA

	// GENERAR 1 COMPRA EN 6 CUOTAS CON FECHA 15/09/2024 QUE CONTENGA 2 PRODUCTOS DE LA TIENDA

	T1.resumenCompras(9,2024);

	return 0;

}
