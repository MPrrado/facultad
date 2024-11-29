/* a) */
SELECT ciudad FROM ciudad
WHERE id_ciudad NOT IN (
SELECT id_ciudad FROM ciudad
INNER JOIN socio USING(id_ciudad)
INNER JOIN venta USING (id_socio)
);

/* b) */

SELECT envio FROM envio
WHERE id_envio NOT IN(
SELECT id_envio FROM envio
INNER JOIN venta USING(id_envio)
);

/* c) */

SELECT ciudad FROM ciudad
WHERE id_ciudad IN (
	SELECT id_socio FROM socio
	INNER JOIN ciudad USING(id_ciudad)
);

/* d) */
SELECT autor FROM autor 
WHERE tipo = "autor" AND id_autor NOT IN (
	SELECT id_autor FROM autor 
    INNER JOIN articulo USING (id_autor)
    INNER JOIN detalle_venta USING(id_articulo)
    INNER JOIN venta USING(id_venta)
    WHERE fecha BETWEEN "2021-06-01" AND "2021-12-31"
);

/* e) */
SELECT id_venta, id_socio, ps.nombre AS nombre_socio, id_empleado, pe.nombre AS nombre_empleado, fecha, importe FROM venta
INNER JOIN socio s USING(id_socio)
INNER JOIN empleado e USING(id_empleado)
INNER JOIN persona ps ON s.id_socio = ps.id_persona
INNER JOIN persona pe ON e.id_empleado = pe.id_persona
WHERE importe > (SELECT AVG(importe) FROM venta);

/* f) */
SELECT nombre, titulo, fecha FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN venta USING (id_socio)
INNER JOIN detalle_venta USING(id_venta)
INNER JOIN articulo USING (id_articulo)
INNER JOIN autor USING (id_autor)
INNER JOIN ciudad USING (id_ciudad)
INNER JOIN (
				SELECT * FROM provincia 
                WHERE provincia IN ("Salta", "Tucuman")
) AS prov USING (id_provincia)
WHERE autor = (
					SELECT autor FROM autor
					INNER JOIN articulo USING (id_autor)
					WHERE titulo = "El Gato Negro"
);

-- g)

SELECT ciudad, provincia, nombre FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
RIGHT JOIN ciudad USING (id_ciudad)
INNER JOIN (
			SELECT * FROM provincia
)as prov USING (id_provincia)
ORDER BY ciudad DESC, nombre ASC;

-- h)
 SELECT id_socio, nombre, SUM(cantidad) AS cantidadArticulosComprados FROM socio s
 INNER JOIN venta USING (id_socio)
 INNER JOIN detalle_venta USING (id_venta)
 INNER JOIN articulo USING (id_articulo)
 INNER JOIN persona p ON s.id_socio = p.id_persona
 GROUP BY id_socio
 HAVING cantidadArticulosComprados > ( SELECT SUM(cantidad) AS cantidad FROM detalle_venta 
 INNER JOIN articulo USING (id_articulo)
 WHERE titulo = "La Mano");

 
-- i)
SELECT id_empleado, nombre, funcion, sueldo, TIMESTAMPDIFF(YEAR, fecha_alta, CURDATE()) AS antiguedad, YEAR(fecha_alta) AS año_ingreso FROM empleado e
INNER JOIN funcion USING(id_funcion)
INNER JOIN persona p ON e.id_empleado = p.id_persona
WHERE TIMESTAMPDIFF(YEAR, fecha_alta, CURDATE()) > 4 AND fecha_alta > (
	SELECT fecha_alta FROM empleado e
    INNER JOIN persona p ON e.id_empleado = p.id_persona
    WHERE nombre = "Valdivia Nadia"
)
ORDER BY antiguedad DESC;

/*
j) Muestre el id, nombre, función y monto total de ventas de los empleados que hayan vendido
menos que el 5% del monto total de las ventas realizadas en Chaco.*/
SELECT id_empleado, nombre, funcion, SUM(total) AS monto_total_vendido FROM persona p
INNER JOIN empleado e ON p.id_persona = e.id_empleado
INNER JOIN funcion USING(id_funcion)
INNER JOIN venta USING(id_empleado)
GROUP BY id_empleado
HAVING monto_total_vendido < 0.05 * (
										SELECT SUM(total) FROM venta
                                        INNER JOIN socio USING(id_socio)
                                        INNER JOIN ciudad USING(id_ciudad)
                                        INNER JOIN provincia USING(id_provincia)
                                        WHERE provincia = "Chaco"
);


/*
k. Muestre las ventas y prestamos del dia 20/09/2020. Se debe mostrar el nombre del socio, la
fecha, el importe (use el total en la venta) y el tipo de operación (venta o préstamo). Ordene
los resultados por el nombre del socio. Ej:
*/

SELECT nombre, fecha, total AS importe , operacion FROM socio s 
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN (
			SELECT id_socio,fecha, total, "Venta" AS operacion FROM venta
			WHERE fecha = "2020-09-20"
			UNION
			SELECT id_socio, inicio_prestamo, monto, "Préstamo" AS operacion FROM prestamo
			WHERE inicio_prestamo = "2020-09-20"
) AS tabla USING(id_socio)
ORDER BY nombre;

/*
LEFT JOIN socio s ON p.id_persona = s.id_socio
LEFT JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING(id_provincia)
WHERE provincia = "Chaco";
*/


-- l) subconsulta en el select con where genero IN ("", "", "")
/*
L)
	Liste los artículos de género Misterio, Comedia y Ficción. Muestre el título, año, precio y el
	promedio de precios del género al corresponden
*/
-- l)
SELECT titulo, anio, precio, precio_promedio, g.genero FROM articulo a
INNER JOIN genero g USING(id_genero)
INNER JOIN (SELECT * FROM (SELECT genero, AVG(precio) as precio_promedio FROM articulo
INNER JOIN genero USING(id_genero)
WHERE genero IN('Misterio','Comedia','Ficción')
GROUP BY genero) AS tabla
) AS t ON g.genero = t.genero
WHERE g.genero IN('Misterio','Comedia','Ficción');

-- m)
start transaction;
UPDATE articulo
SET precio = precio +
(
SELECT * FROM(
SELECT AVG(precio)*0.3 FROM articulo
INNER JOIN genero USING (id_genero)
WHERE genero = 'Aventuras') AS algo
);
rollback;

-- n)
UPDATE venta
INNER JOIN envio USING(id_envio)
SET gasto_envio = gasto_envio + 1000
WHERE envio IN
(
SELECT * FROM(
SELECT envio FROM venta
INNER JOIN envio USING(id_envio)
WHERE fecha = '2020-05-08'
) AS tablaAux
);

-- o)
DELETE FROM funcion f
WHERE funcion NOT IN(SELECT * FROM (SELECT funcion FROM empleado
INNER JOIN funcion USING(id_funcion)
)AS tablaAux
);

-- p)
DELETE FROM prestamo p
WHERE inicio_prestamo < (SELECT fecha FROM venta
INNER JOIN socio USING(id_socio)
INNER JOIN persona ON id_socio = id_persona
WHERE nombre = 'Tejada Gabriela Claudia');



/*m) y n) NO EN TODOS LOS MOTORES ES IGUAL
UPDATE Y SELECT EN LAMISMA TABLA ESTA BIEN PLANTEADO PERO EL DBMS NO ME DEJA.alter
Los UPDATE y DELETE tenemos que hacer subconsulta de subconsulta para tener como si fuera otra tabla*/


/*VISTAS*/

CREATE VIEW info_venta AS
(SELECT s.nombre AS nombre_socio, e.nombre AS nombre_empleado, titulo, dv.precio, fecha_envio AS fecha_entrega, entregado
FROM venta
INNER JOIN persona s ON id_socio = s.id_persona
INNER JOIN persona e ON id_empleado = e.id_persona
INNER JOIN detalle_venta dv USING (id_venta)
INNER JOIN articulo USING (id_articulo)
ORDER BY titulo, fecha);

SELECT * FROM info_venta;

CREATE VIEW info_prestamo AS
(
	SELECT nombre, ciudad, provincia, titulo, autor, genero, editorial, monto, multa, inicio_prestamo AS fecha_inicio, fin_prestamo AS fecha_fin, fecha_devolucion, TIMESTAMPDIFF(DAY, inicio_prestamo, fin_prestamo) AS dias_agendados, TIMESTAMPDIFF(DAY, inicio_prestamo, fecha_devolucion) AS dias_duracion
	FROM persona
	INNER JOIN socio ON id_socio = id_persona
	INNER JOIN prestamo USING(id_socio)
	INNER JOIN ciudad USING(id_ciudad)
	INNER JOIN provincia USING(id_provincia)
	INNER JOIN articulo USING(id_articulo)
	INNER JOIN autor USING(id_autor)
	INNER JOIN genero USING(id_genero)
	INNER JOIN editorial USING(id_editorial)
);

SELECT nombre, titulo, COALESCE(dias_duracion - dias_agendados, 'No devuelto') AS dias_mora FROM info_prestamo;