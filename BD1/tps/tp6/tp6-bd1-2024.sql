/*
	punto 1-
    La tabla editorial no cumple con la 2FN hay que crear otra tabla con los tipos y referenciarlos
    La tabla genero no cumple con la 1FN, pues los valores de los atributos no son atomicos
    
    
*/

SELECT * FROM venta;

/*ejercicio 2*/
/*a)*/
SELECT * FROM persona;

/*b)*/
SELECT editorial FROM editorial
WHERE tipo = "editorial";

/*c)*/
SELECT titulo, anio FROM articulo
WHERE duracion_paginas > 100;

/*d)*/
SELECT id_editorial, editorial FROM editorial
WHERE tipo = "editorial"
ORDER BY editorial;

/*e)*/
SELECT fecha, importe, gasto_envio, total FROM venta
WHERE total > 12000;

/*f)*/
SELECT * FROM prestamo
WHERE fecha_devolucion IS NULL;

/*g)*/
SELECT nombre, dni, sueldo FROM persona p
INNER JOIN empleado e ON p.id_persona = e.id_empleado;

/*h)*/
SELECT nombre, ciudad, provincia FROM persona
INNER JOIN socio ON id_persona = id_socio
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING (id_provincia)
ORDER BY provincia, ciudad DESC, nombre ; /*se puede indicar por "," que se puede ordenar por distintos campos. En el caso de que se repita el primero sigue al segundo */

/*i)*/
SELECT p.nombre AS nombreEmpleado, f.nombre AS NombreFamiliar, parentesco FROM persona p /*si se pone alias se utiliza, no importa que se lo declare mas adelante*/
INNER JOIN empleado e ON p.id_persona = e.id_empleado
INNER JOIN familiar f ON e.id_empleado = f.id_empleado;

/*j)*/
SELECT * FROM venta 
INNER JOIN envio USING(id_envio)
WHERE envio IN ("Andreani", "UPS", "FedEx"); /*OTRA FORMA DE AHORRARME ESCRIBIR. Asi me ahorro usar tantos OR*/

/*k)*/
SELECT nombre, importe, fecha FROM persona p
INNER JOIN socio s ON p.id_persona = s.id_socio
INNER JOIN venta v USING (id_socio)
WHERE fecha BETWEEN '2021-01-01' AND '2021-12-31';



