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