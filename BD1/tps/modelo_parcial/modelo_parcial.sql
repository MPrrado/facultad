/*
i)
	Obtenga el nombre del socio, el título del artículo prestado, la fecha inicio, de fin y devolución del préstamo,
	monto, la multa, la duración, en días, del préstamo y los días que se excedió (días que el socio retuvo el
	artículo después de la finalización del préstamo hasta que lo devolvió), de aquellos préstamosrealizados entre
	01-01-2018 y 31-12-2020, que hayan devuelto el artículo, cuyo monto sea menor que $ 2900 y la multa sea
	mayor a $ 1000. Ordenados de mayor a menor por la cantidad de días y por nombre del socio alfabéticamente.
*/

SELECT nombre, titulo, inicio_prestamo, fin_prestamo, monto, multa, TIMESTAMPDIFF(DAY, inicio_prestamo, fin_prestamo) AS dias_duracion, TIMESTAMPDIFF(DAY, fin_prestamo, fecha_devolucion) AS dias_demora FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN prestamo USING (id_socio)
INNER JOIN articulo USING (id_articulo)
WHERE inicio_prestamo BETWEEN '2018-01-01' AND '2020-12-31' AND fecha_devolucion IS NULL AND multa > 1000 AND monto < 2900; 

/*
ii) 
Liste para cada empleado, el nombre, la función, el sueldo y también la cantidad de familiares y el parentesco
(ejemplo 2 hijo, 1 esposa, 1 padre). En caso de no tener familiares, debe mostrar 0 (cero). Ordenado
alfabéticamente por empleado y luego por parentesco
*/
SELECT p.nombre, funcion, sueldo, COALESCE(CONCAT(COUNT(parentesco),'-', parentesco),CONCAT(0,' FAMILIARES')) AS cantidad_familiares FROM empleado e
INNER JOIN persona p ON e.id_empleado = p.id_persona
INNER JOIN funcion fu USING (id_funcion)
LEFT JOIN familiar f USING (id_empleado)
LEFT JOIN parentesco USING(id_parentesco)
GROUP BY id_empleado, parentesco
ORDER BY nombre, cantidad_familiares;


/*
iii)
Muestre, para cada empresa en envío, el id, nombre, la cantidad de envíos realizados y la cantidad de artículos
entregados por cada una, para los casos donde la cantidad de entregas sea menor a 380. Ordenado por la
cantidad de artículos entregados en forma descendente y luego por empresa de envío alfabéticamente.
*/

SELECT id_envio, envio, COUNT(id_venta) AS cantidad_envios, COALESCE(SUM(cantidad), 0) AS cantidad_articulos FROM envio
LEFT JOIN venta USING (id_envio)
LEFT JOIN detalle_venta USING (id_venta)
GROUP BY id_envio 
HAVING cantidad_envios < 380
ORDER BY cantidad_articulos DESC, envio;

/*
iv. 
Liste el total recaudado por el pago de cada membresía -exceptuando la denominada ‘premium plus’-, en
cada una de las provincias -exceptuando 'Salta' y 'Chaco’-, cuyo monto total sea mayor al total recaudado por
el pago de la membresía ‘plata’ en las provincias de 'Salta' y 'Chaco’. Ordenado por membresía y por provincia
alfabéticamente y por recaudación de mayor a menor
*/

SELECT membresia, SUM(precio) AS recaudado, provincia FROM membresia
LEFT JOIN pago USING (id_membresia)
LEFT JOIN socio USING (id_socio)
LEFT JOIN ciudad USING (id_ciudad)
LEFT JOIN provincia USING (id_provincia)
WHERE membresia != "primiun" AND provincia NOT IN ('Salta', 'Chaco')
GROUP BY membresia, provincia
HAVING recaudado > (
					SELECT SUM(precio) FROM membresia
					INNER JOIN pago USING(id_membresia)
					INNER JOIN socio USING(id_socio)
					INNER JOIN ciudad USING(id_ciudad)
					INNER JOIN provincia USING(id_provincia)
					WHERE membresia = 'plata' AND provincia IN ('Chaco', 'Salta')
)
ORDER BY membresia, provincia;



