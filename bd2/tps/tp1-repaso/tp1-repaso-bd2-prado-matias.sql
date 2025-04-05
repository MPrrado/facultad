SELECT * FROM paciente;

-- 1) Muestre el id, nombre, apellido y dni de los pacientes que no tienen obra social.
SELECT id_persona, nombre, apellido, dni FROM persona pe
INNER JOIN paciente pa ON pa.id_paciente = pe.id_persona
WHERE pa.id_obra_social IS NULL;

/* 2) Liste el id, nombre, apellido y sueldo de los empleados, como así también su cargo y especialidad. 
Ordenado alfabéticamente por cargo, luego por especialidad y en último término por sueldo de mayor a menor.*/

SELECT id_persona, nombre, apellido, sueldo, cargo, especialidad FROM persona pe
INNER JOIN empleado e ON e.id_empleado = pe.id_persona
INNER JOIN cargo USING (id_cargo)
INNER JOIN especialidad USING(id_especialidad)
ORDER BY cargo, especialidad, sueldo DESC;

/*
3) Liste todos los pacientes con obra social que fueron atendidos en los consultorios 'CARDIOLOGIA' o
'NEUMONOLOGIA'. Debe mostrar el nombre, apellido, dni y nombre de la obra social.
*/

SELECT pe.nombre, apellido, dni, os.nombre as nombre_obra_social FROM persona pe
INNER JOIN paciente pa ON pa.id_paciente = pe.id_persona
INNER JOIN obra_social os USING (id_obra_social)
INNER JOIN consulta USING (id_paciente)
INNER JOIN consultorio con USING (id_consultorio)
WHERE con.nombre IN ('CARDIOLOGIA', 'NEUMONOLOGIA')
GROUP BY (pe.nombre, apellido, dni,nombre_obra_social);

/*
4) Encuentre el empleado, cargo y turno de todos los empleados cuyo cargo sea AUXILIAR y el turno de
trabajo aún se encuentre vigente (un empleado puede tener muchos turnos a lo largo del tiempo, mire los
datos en la tabla trabajan para identificar que turnos tuvo y cual tiene actualmente). Ordene por apellido y
nombre.
*/
SELECT nombre, apellido, dni, cargo FROM persona pe
INNER JOIN empleado em ON em.id_empleado = pe.id_persona
INNER JOIN cargo ca USING (id_cargo)
INNER JOIN trabajan USING (id_empleado)
WHERE cargo LIKE ('%AUXILIAR%') AND fin IS NULL;


/*
5) Muestre la cantidad de internaciones que hizo cada médico del área de NEUROLOGÍA. Debe mostrar el id,
nombre completo y la cantidad de internaciones, ordenando por cantidad de mayor a menor
*/

SELECT CONCAT(apellido, ', ' ,nombre) AS nombre, dni, cargo,  COUNT(dni) AS numero_internaciones FROM persona pe
INNER JOIN empleado em ON em.id_empleado = pe.id_persona
INNER JOIN internacion i ON i.ordena_internacion = em.id_empleado
INNER JOIN cargo ca USING (id_cargo)
INNER JOIN especialidad es USING (id_especialidad)
WHERE cargo LIKE ('%MEDICO%') AND especialidad = 'NEUROLOGÍA'
GROUP BY (nombre, pe.apellido,dni, cargo)
ORDER BY numero_internaciones DESC;

/*

6) Muestre los proveedores a los que no se les compró ningún medicamento.
*/

SELECT proveedor FROM proveedor
WHERE id_proveedor NOT IN (SELECT DISTINCT(id_proveedor) FROM proveedor INNER JOIN compra USING(id_proveedor));


/*
7) Muestre los pacientes que tienen obra social, que fueron internados en enero del 2022 en el 8vo piso por
una condición psiquiátrica. Ordene los resultados por la fecha de internación. 
*/

SELECT nombre, apellido, dni FROM persona
INNER JOIN paciente ON id_paciente = id_persona
INNER JOIN internacion USING(id_paciente)
INNER JOIN empleado ON id_empleado = ordena_internacion
INNER JOIN especialidad es USING (id_especialidad)
INNER JOIN cama USING (id_cama)
INNER JOIN habitacion USING (id_habitacion)
WHERE especialidad = 'PSIQUIATRÍA' AND piso = 8 AND EXTRACT(YEAR FROM fecha_inicio) = 2022 AND EXTRACT(MONTH FROM fecha_inicio) = 1;


/*
8) Muestre los 5 medicamentos más recetados y el laboratorio al que pertenecen.
*/

SELECT m.nombre, laboratorio, COUNT(id_medicamento) AS numero_veces_recetado FROM medicamento m
INNER JOIN laboratorio USING(id_laboratorio)
INNER JOIN tratamiento USING (id_medicamento)
GROUP BY id_medicamento, m.nombre, laboratorio
ORDER BY numero_veces_recetado DESC
LIMIT 5;


/*
9) Liste los empleados que no hayan realizado internaciones en el año 2021, mostrando además su cargo.
Ordene los resultados por apellido y nombre.
*/

SELECT apellido, nombre, cargo FROM persona pe
INNER JOIN empleado ON id_empleado = id_persona
INNER JOIN cargo USING (id_cargo)
WHERE id_persona NOT IN (SELECT id_persona FROM persona pe
						INNER JOIN empleado ON id_empleado = id_persona
						INNER JOIN internacion ON ordena_internacion = id_empleado
						WHERE EXTRACT(YEAR FROM fecha_inicio) = 2021)
ORDER BY apellido, nombre
select * from habitacion;
ORDER BY especialidad;


/*
10) Muestre los pacientes a los que les hayan facturado más que ‘LAURA MONICA JABALOYES’ desde el
15/05/2022 a la fecha.
*/


SELECT nombre, apellido, SUM(costo) AS total_cobrado FROM persona
INNER JOIN paciente ON id_persona = id_paciente
INNER JOIN internacion USING(id_paciente)
WHERE fecha_inicio > '2022-05-15'
GROUP BY (nombre, apellido)
HAVING SUM(costo) > (
						SELECT SUM(costo) AS total_cobrado FROM persona
						INNER JOIN paciente ON id_persona = id_paciente
						INNER JOIN internacion USING(id_paciente)
						WHERE nombre = 'LAURA MONICA' AND apellido = 'JABALOYES' AND fecha_inicio > '2022-05-15'
						GROUP BY (id_paciente)
						)

/*
11) Muestre los pacientes que hayan sido internado más veces que MARTA AMALIA GRAMAJO antes del año
2020.
*/

SELECT nombre, apellido, count(id_paciente) AS numero_internaciones FROM persona
INNER JOIN paciente ON id_paciente = id_persona
INNER JOIN internacion USING(id_paciente)
WHERE fecha_inicio > '2022-05-15'
GROUP BY (nombre, apellido)
HAVING count(id_paciente) > (
								SELECT count(id_paciente) AS numero_internaciones FROM persona
								INNER JOIN paciente ON id_paciente = id_persona
								INNER JOIN internacion USING(id_paciente)
								WHERE nombre = 'MARTA AMALIA' AND apellido = 'GRAMAJO'
								)

SELECT nombre, apellido FROM persona
INNER JOIN paciente ON id_persona = id_paciente
where nombre = 'LAURA MONICA' aND apellido = 'JABALOYES'

