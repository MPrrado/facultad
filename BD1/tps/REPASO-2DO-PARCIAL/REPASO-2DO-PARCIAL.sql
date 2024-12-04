/*PRACTICA PARA EL PARCIAL*/
/*TRABAJO PRACTICO 10*/


/*
a). Liste el nombre de las ciudades a las cuales no se envió nunca un artículo indicando, además,
de qué provincia son.
*/
SELECT ciudad, provincia FROM ciudad
INNER JOIN provincia USING(id_provincia)
WHERE id_ciudad NOT IN (
						SELECT DISTINCT id_ciudad FROM venta
                        INNER JOIN socio USING (id_socio)
);
/*SOLUCION*/
SELECT ciudad, provincia FROM ciudad
INNER JOIN provincia USING (id_provincia)
WHERE id_ciudad NOT IN (SELECT DISTINCT id_ciudad FROM venta
 INNER JOIN socio USING(id_socio));
 
 /*
 b. Liste las empresas de envío que no fueron usadas en ninguna venta.
 */
 
 SELECT * FROM envio
 WHERE id_envio NOT IN (
						SELECT DISTINCT id_envio FROM venta
);

/*
c. Liste las ciudades en las que no hay socios
*/
SELECT ciudad FROM ciudad
WHERE id_ciudad NOT IN (
						SELECT DISTINCT id_ciudad FROM socio
);

/*
d. 
Muestre los autores que no vendieron artículos entre los días 01/06/2021 y 31/12/2021.
*/
SELECT autor FROM autor
WHERE id_autor NOT IN (
						SELECT id_autor FROM articulo
                        INNER JOIN detalle_venta USING (id_articulo)
                        INNER JOIN venta USING (id_venta)
                        WHERE fecha BETWEEN '2021-06-01' AND '2021-12-31'-- FECHA SIEMPRE EN FORMATO AAAA-MM-DD
) AND tipo = "autor";

/*
e). 
Obtenga el número de venta, el id y nombre del socio, el id y nombre del empleado, fecha y el
importe de todas las ventas que superaron el importe promedio de venta. Muestre la
información ordenada por importe de mayor a menor, fecha y socio.
*/

SELECT id_venta, id_socio, ps.nombre, id_empleado, pe.nombre, fecha, importe FROM venta
INNER JOIN persona ps ON id_socio = ps.id_persona
INNER JOIN persona pe ON id_empleado = pe.id_persona
WHERE importe > (
				SELECT AVG(importe) AS promedio FROM venta
);

/*
f. 
Obtenga el socio, título y la fecha de todos los artículos que fueron vendidos en Tucumán y
Salta y tienen el mismo autor del artículo de título “El Gato Negro”. Muestre la información
ordenada por título y fecha
*/
SELECT nombre, titulo, fecha FROM articulo
INNER JOIN detalle_venta USING (id_articulo)
INNER JOIN venta USING (id_venta)
INNER JOIN persona p ON id_socio = p.id_persona
INNER JOIN autor USING  (id_autor)
INNER JOIN socio USING (id_socio)
INNER JOIN ciudad USING (id_ciudad)
INNER JOIN provincia USING (id_provincia)
WHERE provincia IN ("Salta", "Tucuman") AND autor = (
				SELECT autor FROM autor
                INNER JOIN articulo USING (id_autor)
                WHERE titulo LIKE "El Gato Negro"
)
ORDER BY titulo, fecha;

/*
g. 
Liste todas las provincias y ciudades y los socios que hay en ellas. Se debe listar todas las
ciudades por más que no tengan socios. Ordene el listado por ciudad en forma descendente y
por socio alfabéticamente.
*/
SELECT provincia, ciudad, id_socio, nombre FROM provincia 
LEFT JOIN ciudad USING (id_provincia)
LEFT JOIN (
			SELECT * FROM socio
            INNER JOIN  persona p ON id_socio = p.id_persona
) AS persona USING(id_ciudad)
ORDER BY ciudad DESC, nombre;

/*
h. Muestre el id, nombre y la cantidad de artículos comprados por los socios que hayan
comprado más artículos que la cantidad total vendida del articulo 'La Mano'.
*/
SELECT id_socio, nombre, SUM(cantidad) AS cantidad_comprados FROM venta
INNER JOIN detalle_venta USING (id_venta)
INNER JOIN persona ON id_socio = id_persona
GROUP BY id_socio
HAVING cantidad_comprados > (
							SELECT SUM(cantidad) FROM articulo
                            INNER JOIN detalle_venta USING (id_articulo)
							WHERE titulo LIKE "La Mano"
);

/*
i.)
 Obtenga una lista con el id, nombre, función, sueldo, antigüedad y año de ingreso de todos los
empleados que tengan más de 4 años de antigüedad y cuyo año de ingreso sea posterior al
año de ingreso de “Valdivia Nadia”. Ordene por antigüedad de mayor a menor.
*/
SELECT *, TIMESTAMPDIFF(YEAR, fecha_alta, CURDATE()) AS antiguedad FROM empleado
INNER JOIN persona ON id_persona = id_empleado
INNER JOIN funcion USING (id_funcion)
WHERE TIMESTAMPDIFF(YEAR, fecha_alta, CURDATE()) > 4 AND fecha_alta > (
																		SELECT fecha_alta FROM empleado
                                                                        INNER JOIN persona ON id_persona = id_empleado
																		WHERE nombre = "Valdivia Nadia");
/*
j.) 
Muestre el id, nombre, función y monto total de ventas de los empleados que hayan vendido
menos que el 5% del monto total de las ventas realizadas en Chaco.
*/

SELECT id_empleado, nombre, funcion, SUM(total) AS monto_total_vendido FROM empleado 
INNER JOIN persona ON id_persona = id_empleado
INNER JOIN funcion USING (id_funcion)
INNER JOIN venta USING (id_empleado)
GROUP BY id_empleado 
HAVING monto_total_vendido < (
								SELECT 0.05* SUM(total) AS monto_total FROM venta
                                INNER JOIN socio USING (id_socio)
                                INNER JOIN ciudad USING (id_ciudad)
                                INNER JOIN provincia USING (id_provincia)
                                WHERE provincia IN ("Chaco")
);

/*
Muestre las ventas y prestamos del dia 20/09/2020. Se debe mostrar el nombre del socio, la
fecha, el importe (use el total en la venta) y el tipo de operación (venta o préstamo). Ordene
los resultados por el nombre del socio. Ej:
*/
SELECT p.nombre, fecha, total AS importe, 'Venta' AS operacion FROM socio
INNER JOIN persona p ON id_persona = id_socio
INNER JOIN venta USING (id_socio)
WHERE fecha = "2020-09-20"
UNION
SELECT nombre, inicio_prestamo, monto AS importe, 'Prestamo' AS operacion FROM socio 
INNER JOIN persona p ON p.id_persona = id_socio
INNER JOIN prestamo USING (id_socio)
WHERE inicio_prestamo = "2020-09-20"
ORDER BY nombre;

/*
l. Liste los artículos de género Misterio, Comedia y Ficción. Muestre el título, año, precio y el
promedio de precios del género al corresponden.
*/

SELECT titulo, anio, precio, genero,  (
										SELECT AVG(precio) FROM articulo
										INNER JOIN genero gs USING (id_genero)
										WHERE gs.genero = gc.genero) AS precio_promedio
FROM articulo 
INNER JOIN genero gc USING (id_genero)
WHERE genero IN ("Misterio", "Comedia","Ficcion");


/*
m)
Modifique el precio de los artículos de género Aventuras y súmele el 30% del promedio de
precios de dicho género.
*/

start transaction;
UPDATE articulo
INNER JOIN genero USING (id_genero)
SET precio = precio + (	
							SELECT * FROM (
											SELECT 0.3* AVG(precio) FROM articulo 
											INNER JOIN genero USING(id_genero) 
											WHERE genero = "Aventuras") AS porcentaje
							)
WHERE genero = "Aventuras";
rollback;

/*
n)
 Modifique el gasto de envío, sumándole $1.000, a todas las ventas que fueron enviadas por la
misma empresa que se usó en la venta del 08/05/2020.
*/
start transaction;
UPDATE venta
INNER JOIN envio USING (id_envio)
SET gasto_envio = gasto_envio + 1000
WHERE id_envio IN  (SELECT id_envio FROM (SELECT id_envio FROM venta INNER JOIN envio USING (id_envio) WHERE fecha = "2020-5-8" LIMIT 1) AS algo);
rollback;


/*
o. Elimine las funciones que no fueron asignadas a ningún empleado.
*/

start transaction;
DELETE FROM funcion
WHERE id_funcion NOT IN (SELECT * FROM
							(SELECT id_funcion FROM funcion
                            INNER JOIN empleado USING (id_funcion)) AS algo
);
rollback;

/*
p. Elimine los préstamos cuya fecha de préstamo sea menor que la fecha de la venta realizada al
socio “Tejada Gabriela Claudia”
*/

start transaction;
DELETE FROM prestamo
WHERE inicio_prestamo < (SELECT fecha FROM 
							(SELECT fecha FROM venta
                            INNER JOIN socio USING (id_socio)
                            INNER JOIN persona ON id_persona = id_socio
                            WHERE nombre LIKE "Tejada Gabriela Claudia") AS algo
);
rollback;


/*----------VISTAS--------------*/

/*
a. Genere una vista llamada info_venta que muestre el nombre del empleado, el nombre del
socio, el título del artículo, el precio (tabla detalle_venta) de todos los artículos vendidos, la
fecha de envío cada uno de los artículos, la fecha de entrega y si fue entregado. Ordene los
resultados por artículo y la fecha de venta.
*/
start transaction;
CREATE VIEW info_venta AS(
							SELECT pe.nombre, titulo, dv.precio, fecha_envio, entregado FROM venta v
                            INNER JOIN empleado e USING (id_empleado )
                            INNER JOIN persona pe ON pe.id_persona = e.id_empleado
                            INNER JOIN socio s USING(id_socio)
                            INNER JOIN persona ps ON ps.id_persona = s.id_socio
                            INNER JOIN detalle_venta dv USING(id_venta)
                            INNER JOIN articulo USING(id_articulo)
                            ORDER BY titulo, fecha
);
SELECT * FROM info_venta;
rollback;

/*
b. Genere una vista llamada info_prestamo que muestre el nombre, la ciudad y provincia del
socio, el título del artículo, autor, género, origen, editorial, el monto y la multa de todos los
artículos prestados, la fecha de inicio préstamo, fecha del fin, fecha de devolución, la cantidad
de días agendada para el préstamo (de acuerdo a las fechas de inicio y fin) y la cantidad de
días que duró cada préstamo realmente, considerando la fecha de inicio y devolución.
• Una vez creada la vista muestre nombre del socio, título del artículo, y la diferencia en
días de mora en la devolución.
*/

CREATE VIEW info_prestamo AS (
								SELECT nombre, ciudad, provincia, titulo, autor, 
                                genero, origen, editorial, monto, multa, inicio_prestamo, fin_prestamo, fecha_devolucion, 
                                TIMESTAMPDIFF(DAY, inicio_prestamo, fin_prestamo) AS duracion_esperada_en_dias, 
                                TIMESTAMPDIFF(DAY, inicio_prestamo, fecha_devolucion) AS duracion_real_prestamo FROM articulo
                                LEFT JOIN autor USING(id_autor)
								LEFT JOIN genero USING(id_genero)
								LEFT JOIN origen USING(id_origen)
								LEFT JOIN editorial USING(id_editorial)
								INNER JOIN prestamo USING(id_articulo)
								INNER JOIN socio USING(id_socio)
								INNER JOIN persona ON id_persona = id_socio
								INNER JOIN ciudad USING(id_ciudad)
								INNER JOIN provincia USING(id_provincia)
                                );
SELECT nombre, titulo, COALESCE( duracion_real_prestamo - duracion_esperada_en_dias, 'No devuelto') AS mora
FROM info_prestamo;


/*---------------------------------- TP-REPASO-PARCIAL----------------------------------*/

/*
i. Obtenga el nombre del socio, el título del artículo prestado, la fecha inicio, de fin y devolución del préstamo,
monto, la multa, la duración, en días, del préstamo y los días que se excedió (días que el socio retuvo el
artículo después de la finalización del préstamo hasta que lo devolvió), de aquellos préstamosrealizados entre
01-01-2018 y 31-12-2020, que hayan devuelto el artículo, cuyo monto sea menor que $ 2900 y la multa sea
mayor a $ 1000. Ordenados de mayor a menor por la cantidad de días y por nombre del socio alfabéticamente.
*/

SELECT nombre, titulo, inicio_prestamo, fin_prestamo, fecha_devolucion, monto, multa,
TIMESTAMPDIFF(DAY,inicio_prestamo, fin_prestamo) AS duracion,
COALESCE(TIMESTAMPDIFF(DAY, CURDATE(), fecha_devolucion), "SIN DEVOLVER") AS dias_excedido
FROM prestamo
INNER JOIN articulo USING(id_articulo)
INNER JOIN socio USING(id_socio)
INNER JOIN persona on id_persona = id_socio
WHERE inicio_prestamo BETWEEN "2018-01-01" AND "2020-12-31" AND multa IS NOT NULL AND monto < 2900 AND multa > 1000;

/*
ii. Liste para cada empleado, el nombre, la función, el sueldo y también la cantidad de familiares y el parentesco
(ejemplo 2 hijo, 1 esposa, 1 padre). En caso de no tener familiares, debe mostrar 0 (cero). Ordenado
alfabéticamente por empleado y luego por parentesco.
*/

SELECT id_empleado, p.nombre, funcion, sueldo, COALESCE(CONCAT(COUNT(id_parentesco)," ", parentesco), 0) AS cantidad_familiares FROM empleado e
INNER JOIN persona p ON e.id_empleado = id_persona
LEFT JOIN familiar f USING(id_empleado)
LEFT JOIN funcion USING(id_funcion)
LEFT JOIN parentesco USING (id_parentesco)
GROUP BY id_empleado, id_parentesco
ORDER BY nombre, parentesco;

/*
iii. Muestre, para cada empresa en envío, el id, nombre, la cantidad de envíos realizados y la cantidad de artículos
entregados por cada una, para los casos donde la cantidad de entregas sea menor a 380. Ordenado por la
cantidad de artículos entregados en forma descendente y luego por empresa de envío alfabéticamente.
*/

SELECT id_envio, envio, COUNT(id_envio) AS cantidad_envio FROM envio
INNER JOIN venta USING (id_envio)
GROUP BY id_envio
HAVING cantidad_envio < 380
ORDER BY cantidad_envio DESC, envio;

/*
iv. Liste el total recaudado por el pago de cada membresía -exceptuando la denominada ‘premium plus’-, en
cada una de las provincias -exceptuando 'Salta' y 'Chaco’-, cuyo monto total sea mayor al total recaudado por
el pago de la membresía ‘plata’ en las provincias de 'Salta' y 'Chaco’. Ordenado por membresía y por provincia
alfabéticamente y por recaudación de mayor a menor.
*/

SELECT provincia, membresia, SUM(precio) AS recaudado FROM membresia
LEFT JOIN pago USING (id_membresia)
LEFT JOIN socio USING(id_socio)
LEFT JOIN ciudad USING(id_ciudad)
LEFT JOIN provincia USING(id_provincia)
WHERE membresia <> "primiun" AND provincia NOT IN ("Salta", "Chaco")
GROUP BY id_provincia, id_membresia
HAVING recaudado > (
					SELECT SUM(precio) FROM membresia
                    LEFT JOIN pago USING (id_membresia)
					LEFT JOIN socio USING(id_socio)
					LEFT JOIN ciudad USING(id_ciudad)
					LEFT JOIN provincia USING(id_provincia)
                    WHERE provincia IN ("Salta", "Chaco") AND membresia = "Plata"
)
ORDER BY membresia, provincia, recaudado DESC;

/*
v. Genere una vista llamada info_venta que muestre el id_venta (con el título en la columna que sea “número
de venta”), el nombre del socio, los campos ciudad y provincia del mismo separados por coma en un solo
campo llamado “domicilio”, el nombre del empleado, el sueldo y la función del mismo, la fecha y el total de
la venta, el nombre empresa, el gasto y la fecha de envío y por último: la diferencia en días que hay entre la
fecha de la venta y la fecha de envío, bajo el título de columna “plazo_de_entrega”. Ordenado por fecha de
venta. 
*/
CREATE VIEW info_venta AS (
							SELECT id_venta AS  numero_de_venta, ps.nombre AS nombre_socio, CONCAT(ciudad,", ", provincia) AS domicilio, pe.nombre AS nombre_empleado, sueldo, funcion, fecha, total, envio,
                            gasto_envio, fecha_envio, TIMESTAMPDIFF(DAY, fecha, fecha_envio) AS plazo_de_entrega FROM venta
                            INNER JOIN socio AS s USING (id_socio)
                            INNER JOIN persona AS ps ON s.id_socio = ps.id_persona
                            INNER JOIN empleado AS e USING (id_empleado)
                            INNER JOIN persona AS pe ON e.id_empleado = pe.id_persona
                            INNER JOIN ciudad USING (id_ciudad)
                            INNER JOIN provincia USING (id_provincia)
                            INNER JOIN funcion USING(id_funcion)
                            INNER JOIN envio USING (id_envio)
                            ORDER BY fecha
);

CREATE SCHEMA `veterinaria`; -- creamos la base de datos limpia, sin tablas

CREATE TABLE `veterinaria`.`persona` ( -- creamos la tabla persona para poder despues tener las fk de las siguientes tablas
  `id_persona` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`id_persona`));
  
CREATE TABLE `veterinaria`.`duenio` (
	`id_duenio` INT NOT NULL,
	`domicilio` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`id_duenio`),
	CONSTRAINT `fk_persona`
    FOREIGN KEY (`id_duenio`)
    REFERENCES `veterinaria`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
    
CREATE TABLE `veterinaria`.`veterinario` (
  `id_veterinario` INT NOT NULL,
  `especialidad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_veterinario`),
  CONSTRAINT `fk_veterinario`
	FOREIGN KEY (`id_veterinario`)
	REFERENCES `veterinaria`.`persona` (`id_persona`)
	ON DELETE NO ACTION
	ON UPDATE CASCADE);
    
CREATE TABLE `veterinaria`.`raza` (
  `id_raza` INT NOT NULL,
  `raza` VARCHAR(45) NOT NULL,
  `caracteristicas` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_raza`));

CREATE TABLE `veterinaria`.`mascota` (
  `id_mascota` INT NOT NULL,
  `mascota` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `id_duenio` INT NULL,
  `id_raza` INT NULL,
  PRIMARY KEY (`id_mascota`),
  CONSTRAINT `fk_raza`
    FOREIGN KEY (`id_raza`)
    REFERENCES `veterinaria`.`raza` (`id_raza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_duenio`
    FOREIGN KEY (`id_duenio`)
    REFERENCES `veterinaria`.`duenio` (`id_duenio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


/*---------------------------- tp9 ---------------------------*/

/*------- EJERCICIO 2-------*/
/*a)*/
ALTER TABLE venta
	MODIFY importe DECIMAL(10,2) DEFAULT(0),
    MODIFY gasto_envio DECIMAL(10,2) DEFAULT(0),
    MODIFY total DECIMAL(10,2) DEFAULT(0);
/*b)
El campo cantidad de la tabla detalle_venta no puede ser menor que 1 (uno)
*/

ALTER TABLE detalle_venta
	ADD CONSTRAINT check_cantidad CHECK(cantidad >= 1);
    
/*c)
Agregue el campo estado_multa VARCHAR (8) a la tabla prestamo
*/
ALTER TABLE prestamo
	ADD estado_multa VARCHAR(8);
    
/*
D) El campo domicilio de la tabla persona no puede ser nulo.
*/
ALTER TABLE persona
	MODIFY domicilio VARCHAR(100) NOT NULL;
/*
E) Los campos origen, autor y editorial de sus respectivas tablas, no deben permitir
repetidos.
*/
ALTER TABLE origen
	MODIFY origen VARCHAR(45) UNIQUE;
ALTER TABLE autor
	MODIFY autor VARCHAR(50) UNIQUE;
ALTER TABLE editorial
	MODIFY editorial VARCHAR(50) UNIQUE;
    
/*---------- EJERCICIO 3 ----------*/
CREATE TABLE proveedor(
	id_proveedor INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(8) NOT NULL,
    domicilio VARCHAR(100),
    telefono VARCHAR(10)
);

/*------------ ejercicio 5 ------------------*/

CREATE TABLE parentesco (
	id_parentesco INT AUTO_INCREMENT,
	PRIMARY KEY (id_parentesco),
	parentesco VARCHAR (50) NOT NULL
);

ALTER TABLE familiar
	ADD id_parentesco INT,
    ADD CONSTRAINT fk_parentesco FOREIGN KEY (id_parentesco) REFERENCES parentesco(id_parentesco);
    
INSERT INTO parentesco (parentesco)
SELECT DISTINCT parentesco FROM familiar;

UPDATE familiar f
INNER JOIN parentesco p ON f.parentesco = p.parentesco
SET f.id_parentesco = p.id_parentesco;

ALTER TABLE familiar
DROP COLUMN parentesco;

    


                        