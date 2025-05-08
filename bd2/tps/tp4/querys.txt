-- ejercicio 1
BEGIN TRANSACTION;

UPDATE medicamento  SET precio = precio * 1.05
FROM clasificacion , laboratorio 
WHERE medicamento.id_laboratorio = laboratorio.id_laboratorio AND medicamento.id_clasificacion = clasificacion.id_clasificacion AND laboratorio.laboratorio LIKE '%ABBOTT LABORATORIOS%' AND clasificacion.clasificacion like '%ANTIINFECCIOSOS%'

UPDATE medicamento m SET precio = precio * 0.975
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio like '%BRISTOL CONSUMO%' AND clasificacion LIKE '%ANTIINFECCIOSOS%'


UPDATE medicamento m SET precio = precio * 0.955
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio like '%FARMINDUSTRIA%' AND clasificacion LIKE '%ANTIINFECCIOSOS%'


UPDATE medicamento m SET precio = precio * 1.07
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio not in ('ABBOTT LABORATORIOS', 'BRISTOL CONSUMO', 'FARMINDUSTRIA')AND clasificacion LIKE '%ANTIINFECCIOSOS%'

COMMIT -- LO HACEMOS AL FINAL UNA VEZ OBTENIDO EL EXITO EN LAS CONSULTAS

ROLLBACK;

-- EJERCICIO 2

START TRANSACTION;

INSERT INTO persona(id_persona, apellido, nombre, dni, fecha_nacimiento, domicilio, telefono)
VALUES ((SELECT MAX(id_persona) +1 FROM persona),'PEREZ','JUAN', '31722586', '1984-08-20', 'AV. MITRE 643', '54-381-326-1780')

INSERT INTO paciente(id_paciente, id_obra_social)
VALUES((SELECT MAX(id_persona) FROM persona), (SELECT id_obra_social FROM obra_social WHERE nombre = 'OBRA SOCIAL DE LOCUTORES'))

SELECT * FROM persona 
ORDER BY id_persona DESC;
LIMIT 1

COMMIT
ROLLBACK;

START TRANSACTION;

--EJERCICIO 3
--a)
	
INSERT INTO estudio_realizado(id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
VALUES ((	SELECT id_persona FROM persona
			WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'),
		(	SELECT id_estudio FROM estudio 
		 	WHERE nombre = 'ESPIROMETRIA COMPUTADA'), '2025-04-15', 
		(	SELECT id_equipo FROM equipo 
		 	WHERE nombre = 'LARINGOSCOPIO'), 
		(	SELECT id_empleado FROM empleado
		 	INNER JOIN persona ON id_empleado = id_persona
		 	WHERE nombre = 'EVA' AND apellido = 'ROJO'), 'NORMAL', 'NO SE OBSERVAN IRREGULARIDADES.', 3280.00)
SELECT * FROM estudio_realizado
WHERE id_paciente = (SELECT MAX(id_paciente) FROM paciente)
COMMIT 
ROLLBACK;

--b)

START TRANSACTION;

INSERT INTO internacion(id_paciente, id_cama, fecha_inicio, ordena_internacion)
VALUES ((	SELECT id_persona FROM persona
			WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'),157, '2025-04-16',
		(	SELECT id_empleado FROM empleado
		 	INNER JOIN persona ON id_empleado = id_persona
		 	WHERE nombre = 'PAULA DANIELA' AND apellido = 'ALBORNOZ'))

SELECT * FROM internacion
WHERE id_paciente = (SELECT MAX(id_paciente) FROM paciente) 

COMMIT;

ROLLBACK;

--c)

START TRANSACTION;

INSERT INTO tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
VALUES ((	SELECT id_persona FROM persona
			WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'),
		(	SELECT id_medicamento FROM medicamento 
		 	WHERE nombre = 'AFRIN ADULTOS SOL'), '2025-04-16', 
		(	SELECT id_empleado FROM empleado
		 	INNER JOIN persona ON id_empleado = id_persona
		 	WHERE nombre = 'PAULA DANIELA' AND apellido ='ALBORNOZ'), 'AFRIN ADULTOS SOL', 'FRASCO X 15 CC', 1, 1821.79)
			
INSERT INTO tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
VALUES ((	SELECT id_persona FROM persona
			WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'),
		(	SELECT id_medicamento FROM medicamento 
		 	WHERE nombre = 'NAFAZOL'), '2025-04-16', 
		(	SELECT id_empleado FROM empleado
		 	INNER JOIN persona ON id_empleado = id_persona
		 	WHERE nombre = 'PAULA DANIELA' AND apellido ='ALBORNOZ'), 'NAFAZOL', 'FRASCO X 15 ML', 2, 1850.96)
			
INSERT INTO tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
VALUES ((	SELECT id_persona FROM persona
			WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'),
		(	SELECT id_medicamento FROM medicamento 
		 	WHERE nombre = 'VIBROCIL GOTAS NASALES'), '2025-04-16', 
		(	SELECT id_empleado FROM empleado
		 	INNER JOIN persona ON id_empleado = id_persona
		 	WHERE nombre = 'PAULA DANIELA' AND apellido ='ALBORNOZ'), 'VIBROCIL GOTAS NASALES', 'FRASCO X 15 CC', 2, 2500.66)

--prueba para ver si se añadieron
SELECT * FROM tratamiento
WHERE nombre = 'NAFAZOL' AND id_paciente =(SELECT MAX(id_paciente) FROM paciente)

SELECT * FROM tratamiento
WHERE nombre = 'AFRIN ADULTOS SOL' AND id_paciente =(SELECT MAX(id_paciente) FROM paciente)

SELECT * FROM tratamiento
WHERE nombre = 'VIBROCIL GOTAS NASALES' AND id_paciente =(SELECT MAX(id_paciente) FROM paciente)


COMMIT;
ROLLBACK;

--d)

START TRANSACTION;

UPDATE internacion SET fecha_alta = '2025-04-19', hora = '11:30:00', costo = 120000.00
WHERE id_cama = 157 AND fecha_inicio = '2025-04-16' AND id_paciente = (	SELECT id_paciente FROM persona
						INNER JOIN paciente ON id_persona = id_paciente
						WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586')
select * from internacion
WHERE id_cama = 157 AND id_paciente = (select max(id_paciente) FROM paciente)
COMMIT
ROLLBACK;

--EJERCICIO 4
START TRANSACTION;
INSERT INTO factura (id_factura, id_paciente, fecha, hora, monto)
VALUES((SELECT MAX(id_factura)+1 FROM factura), (SELECT id_persona FROM persona WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586'), CURRENT_DATE, CURRENT_TIME(0), (SELECT SUM(valor_total) FROM(	SELECT precio AS valor_total FROM estudio_realizado
																	 WHERE id_paciente = (SELECT id_persona FROM persona 
																						  WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586')
																		UNION
																	SELECT SUM(costo) FROM tratamiento
																	WHERE id_paciente = (SELECT id_persona FROM persona 
																						  WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586')
	  																	UNION
																	SELECT costo FROM internacion
	   																WHERE fecha_alta = '2025-04-19' AND id_paciente = (SELECT id_persona FROM persona 
																						  WHERE nombre = 'JUAN' AND apellido = 'PEREZ' AND dni = '31722586')) AS tabla))--CURRENT_TIME(0) ME DEVUELVE LA HORA SIN MILISEGUNDOS
SELECT * FROM factura
WHERE id_factura = (select max(id_factura)from factura)
COMMIT;
ROLLBACK;

--5a) 
START TRANSACTION;

UPDATE patologia SET nombre = 'PRADO'
WHERE id_patologia = 1

SELECT * FROM patologia
WHERE id_patologia = 1

/*
Luego de realizar el commit lo que veo es el dato actualizado
entonces podemos decir que la aislacion tuvo un NIVEL DE AISLAMIENTO POR DEFECTO (VER TEORIA)
*/
COMMIT;
ROLLBACK;

--B)
START TRANSACTION;

--ACTUALIZAMOS LA PATOLOGIA CON MI NOMBRE
UPDATE patologia SET nombre = 'MATIAS'
WHERE id_patologia = 1

commit

SELECT * FROM patologia
WHERE id_patologia = 1

/*
Luego de realizado el commit lo que veo es el valor de la patologia actualizada
*/
ROLLBACK;

--EJERCICIO 6
--a)
START TRANSACTION;
/*Aumente el sueldo en un 25%, de los empleados cuyo cargo es “DIRECTOR”. */

UPDATE empleado e SET sueldo = sueldo * 1.25
FROM cargo c
WHERE e.id_cargo = c.id_cargo AND cargo = 'DIRECTOR'

SELECT sueldo FROM persona
INNER JOIN empleado ON id_persona = id_empleado
INNER JOIN cargo USING(id_cargo)

COMMIT;
ROLLBACK;

--b)
/*
Aumente el sueldo en un 20%, de los empleados cuyo cargo es “DIRECTOR AREA OPERATIVA”. Verifique los
datos, si el sueldo con el aumento supera los $110.000, deshaga los cambios.
*/
START TRANSACTION;

UPDATE empleado e SET sueldo = sueldo * 1.2
FROM cargo c
WHERE e.id_cargo = c.id_cargo AND cargo = 'DIRECTOR AREA OPERATIVA' AND fecha_baja IS NULL AND (sueldo*1.2) < 110000 

SELECT * FROM persona
INNER JOIN empleado ON id_persona = id_empleado
INNER JOIN cargo USING(id_cargo)
WHERE cargo = 'DIRECTOR AREA OPERATIVA'

COMMIT;
ROLLBACK;

-- C)
/*
Aumente el sueldo en un 15%, de los empleados cuyo cargo es “DIRECTOR FISCALIZACION SANITARIA”.
Verifique los datos, si el sueldo con el aumento supera los $105.000, deshaga los cambios.
*/

START TRANSACTION;
UPDATE empleado e SET sueldo = sueldo * 1.15
FROM cargo c
WHERE e.id_cargo = c.id_cargo AND cargo = 'DIRECTOR FISCALIZACION SANITARIA' AND fecha_baja IS NULL AND (sueldo*1.15) < 105000 

SELECT * FROM persona
INNER JOIN empleado ON id_persona = id_empleado
INNER JOIN cargo USING(id_cargo)
WHERE cargo = 'DIRECTOR FISCALIZACION SANITARIA'
ROLLBACK;

--EJERCICIO 7
/*
El día 20/04/2025 el empleado LENES, RUBEN realizó la compra de 200 DORIXINA (comprimidos) al proveedor
DECO S.A
*/
START TRANSACTION;

INSERT INTO compra (id_medicamento, id_proveedor, fecha, id_empleado, precio_unitario, cantidad)
VALUES((SELECT id_medicamento FROM medicamento WHERE nombre = 'DORIXINA'), (SELECT id_proveedor FROM proveedor WHERE proveedor = 'DECO S.A.'), '2025-04-20', (SELECT id_persona FROM persona WHERE nombre = 'RUBEN' and apellido = 'LENES'), SELECT precio_unitario * 0.7 FROM (SELECT precio AS precio_unitario FROM medicamento WHERE nombre = 'DORIXINA') AS tabla, 200)

ROLLBACK;

/*
El dia 23/04/2025 la empleada DIAZ, ADRIANA SONIA realizó a compra de 60 TRAMAL GOTAS al proveedor
DIFESA.
*/
START TRANSACTION;

INSERT INTO compra (id_medicamento, id_proveedor, fecha, id_empleado, precio_unitario, cantidad)
VALUES((SELECT id_medicamento FROM medicamento WHERE nombre = 'TRAMAL GOTA'), (SELECT id_proveedor FROM proveedor WHERE proveedor = 'DIFESA'), '2025-04-23', (SELECT id_persona FROM persona WHERE nombre = 'ADRIANA SONIA' and apellido = 'DIAZ'), SELECT precio_unitario * 0.7 FROM (SELECT precio AS precio_unitario FROM medicamento WHERE nombre = 'TRAMAL GOTA') AS tabla, 60)

ROLLBACK;

--EJERCICIO 8 

START TRANSACTION;

DELETE FROM medicamento
WHERE nombre = 'SINEMET'
ROLLBACK;
