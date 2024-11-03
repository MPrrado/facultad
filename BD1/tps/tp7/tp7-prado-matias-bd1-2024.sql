/*EJEMPLO DE GROUP BY.
par este caso lo que hacemos es contar la cantidad de ventas que estan asociadas con determinado socio. Obteniendo asi la 
cantida de veces que se vendio algo a un socio*/

SELECT s.id_socio, p.nombre, COUNT(id_socio) AS cantidad
FROM socio AS s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN venta USING (id_socio)
GROUP BY id_socio, p.nombre;

/*EJERCICIO 1*/

/*a)*/
SELECT ROUND (AVG(precio),2) AS precioPromedio FROM articulo;

/*b)*/
SELECT MAX(sueldo) AS SueldoMax FROM empleado;

/*c)*/
SELECT MIN(precio) AS membresia_economica FROM membresia /*para poder mostrar el nombre de la membresia es necesario que haya un GROUP BY. Por lo tanto para mostrar otro campo cuando se usa una funcion de agregacion tiene que haber GROUP BY*/
WHERE membresia != 'basico';

/*d)*/
SELECT COUNT(multa) AS NoDevueltos FROM prestamo
WHERE multa IS NOT NULL;

/*e)*/
SELECT SUM(multa) AS montoTotalMultas FROM prestamo
WHERE multa IS NOT NULL;

/*f)*/
SELECT inicio_prestamo, fin_prestamo, COALESCE(fecha_devolucion,'No Devuelto') FROM prestamo /*COALESCE(campo1,campo2, miCambio) si campo1 es null intenta con campo2 sino reemplaza por miCambio*/
WHERE inicio_prestamo BETWEEN '2020-9-1' AND '2020-9-30'
ORDER BY fin_prestamo;

/*g)*/
SELECT COUNT(id_articulo) AS cantidad_prestamos FROM prestamo
INNER JOIN articulo USING(id_articulo)
WHERE titulo = 'Crepusculo';

/*h)*/
SELECT p.nombre, COUNT(id_empleado) AS cantidadFamiliares, id_empleado FROM empleado e
INNER JOIN familiar USING(id_empleado)
INNER JOIN persona p ON e.id_empleado = p.id_persona
GROUP BY id_empleado;

/*i)*/
SELECT ciudad, provincia, COUNT(id_ciudad) AS cantidadSocios FROM socio
INNER JOIN ciudad USING (id_ciudad)
INNER JOIN provincia USING(id_provincia)
GROUP BY id_ciudad
ORDER BY provincia, ciudad;
SELECT * FROM familiar;

/*j)*/
SELECT editorial, COUNT(id_editorial) AS articulosProducidos FROM editorial
INNER JOIN articulo USING (id_editorial)
WHERE tipo = 'editorial'
GROUP BY id_editorial
ORDER BY articulosProducidos DESC
LIMIT 1;

/*K*/
SELECT id_articulo,titulo,a.precio, SUM(cantidad) AS cantidadVendida FROM articulo a
INNER JOIN detalle_venta USING (id_articulo)
INNER JOIN venta v USING(id_venta)
WHERE (YEAR(fecha) = 2019 OR YEAR(fecha) = 2020) AND a.precio >4000
GROUP BY id_articulo
ORDER BY cantidadVendida DESC;

/*l*/
SELECT membresia, mes, anio, COUNT(mes) AS cantidadVendidaEnElMes, SUM(precio) AS recaudado FROM membresia m
INNER JOIN pago p USING(id_membresia)
WHERE fecha_pago <= "2021-12-31" 
GROUP BY membresia, anio, mes
HAVING recaudado > 60000 /*HAVING lo uso como el WHERE pero para poder filtrar las operaciones de agregacion*/
ORDER BY membresia, mes DESC, anio DESC;

/*m*/
SELECT nombre, SUM(cantidad) AS cantidadArticulosComprados, SUM(precio) AS totalCompra FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN venta v USING(id_socio)
INNER JOIN detalle_venta dv USING(id_venta)
GROUP BY id_socio
HAVING cantidadArticulosComprados >= 15
ORDER BY cantidadArticulosComprados DESC, totalCompra DESC;

/*n*/
SELECT nombre, funcion, sueldo, TRUNCATE((DATEDIFF(CURRENT_DATE, fecha_alta) / 365),0) AS antiguedad FROM empleado e
INNER JOIN persona p ON e.id_empleado = p.id_persona
INNER JOIN funcion f USING(id_funcion);

/*o*/
SELECT nombre, CONCAT(domicilio, ' - ', ciudad, ' - ', UPPER(provincia)) AS domicilioCompleto FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN ciudad c USING(id_ciudad)
INNER JOIN provincia pcia USING(id_provincia);

/*p*/
SELECT  COUNT(id_empleado) AS cantidadEmpleados, TRUNCATE((DATEDIFF(CURRENT_DATE, fecha_alta) / 365),0) AS antiguedad FROM empleado e
INNER JOIN persona p ON e.id_empleado = p.id_persona
INNER JOIN funcion f USING(id_funcion)
GROUP BY antiguedad
HAVING antiguedad IN(1,2,3);

/*q*/
SELECT nombre, DATE_FORMAT(fecha_alta, '%d de %M del %Y') AS FechaIngreso, UPPER(LEFT(funcion,3)) AS funcion FROM empleado e
INNER JOIN persona p ON e.id_empleado = p.id_persona
INNER JOIN funcion f USING(id_funcion)
ORDER BY funcion;

/*r*/
SELECT nombre FROM persona
ORDER BY LENGTH(nombre)  DESC
LIMIT 1;

/*s*/

select * from FUNCION;



