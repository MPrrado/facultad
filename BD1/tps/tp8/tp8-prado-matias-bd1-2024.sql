/*EJERCICIO 1*/
/*a)*/
SELECT e.id_empleado, p.nombre, f.nombre, parentesco FROM persona p
INNER JOIN empleado e ON  p.id_persona = e.id_empleado
LEFT JOIN familiar f USING(id_empleado);

/*b)*/
SELECT a.titulo, precio, COALESCE(autor, 'SIN AUTOR') AS autor, COALESCE(editorial, 'SIN EDITORIAL') AS editorial, COALESCE(origen, 'SIN ORIGEN') AS origen, COALESCE(genero, 'SIN GENERO') AS genero FROM articulo a
LEFT JOIN autor USING(id_autor)
LEFT JOIN editorial e USING(id_editorial)
LEFT JOIN origen o USING(id_origen)
LEFT JOIN genero g USING(id_genero);

/*c)*/
SELECT funcion, COUNT(id_empleado) AS cantidadEmpleados FROM funcion f /*tengo que hacer el COUNT(id_empleado) puesto que necesito contar la cantidad de empleados que tiene cada funcion y agrupando por el id_funcion para poder generar los grupos y cantidades de cada funcion*/
LEFT JOIN empleado e USING (id_funcion)
GROUP BY id_funcion;

/*d)*/
SELECT p.nombre, COUNT(f.dni) AS cantidadFamiliares FROM empleado e
LEFT JOIN persona p ON e.id_empleado = p.id_persona
LEFT JOIN familiar f USING(id_empleado)
GROUP BY id_empleado;

/*ejercicio 2*/
INSERT INTO autor (id_autor, autor, tipo) 
VALUES
(149, " BeynonDavies Paul", "autor"),
(150, "Macon Dolores", "autor"),
(151, "Juan Carlos Orós", "autor");

INSERT INTO editorial (id_editorial, editorial, tipo) 
VALUES
(84, "Editorial Reverté", "editorial"),
(85, "RC libros", "editorial");

INSERT INTO genero (id_genero, genero) VALUES(42, "Informática");

INSERT INTO articulo (id_articulo, id_autor, id_editorial, id_genero, titulo, duracion_paginas, anio, precio, id_origen) VALUES(393, 149, 84, 42, "Sistemas de Bases de Datos", 686, 2010, 24954,11);
INSERT INTO articulo (id_articulo, id_autor, id_editorial, id_genero, titulo, duracion_paginas, anio, precio, id_origen) VALUES(394, 150, 33, 42, "Bases de datos. Casos prácticos desde el análisis a la implementación", 492, 2012, 15432,9);
INSERT INTO articulo (id_articulo, id_autor, id_editorial, id_genero, titulo, duracion_paginas, anio, precio, id_origen) VALUES(395, 151, 85, 42, "PYTHON. Curso práctico de formación", 280, 2022, 9581,9);

/*b)*/
INSERT INTO prestamo (id_articulo, id_socio, inicio_prestamo, fin_prestamo)
SELECT 274, id_socio, CURDATE() AS inicio_prestamo , ADDDATE(CURDATE(), INTERVAL 1 MONTH) AS fin_prestamo FROM socio
WHERE id_ciudad = 554 ;

/*c*/
DELETE FROM envio WHERE envio = "Aerobox";

/*d*/
DELETE FROM ciudad WHERE ciudad IN("Casabindo", "La Toma", "San Jose de Feliciano");

/*e*/

select * from socio
inner join ciudad using (id_ciudad)
inner join prestamo using (id_socio)
where id_ciudad = 554 AND id_articulo = 274;

select * from prestamo;
select * from articulo
WHERE titulo like "%la hoja%";
