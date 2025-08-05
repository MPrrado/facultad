/*
Informes
a) Mostrar datos de los pacientes, si tiene obra social, también el nombre de la misma.
b) Mostrar las consultas a las que asistió el paciente, también debe mostrar el medico que lo atendió, el
diagnóstico y el tratamiento que le suministró.
c) Mostrar las internaciones que tuvo el paciente, debe mostrar la habitación y la cama en la que estuvo.
d) Mostrar los estudios que le realizaron, los equipos que se utilizaron y el profesional que le realizo el
estudio.
*/
--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_informes WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_informes WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_informes TO pradom_informes;

--asignamos los permisos
GRANT SELECT ON TABLE public.cama TO pradom_grupo_informes;

GRANT SELECT ON TABLE consulta, diagnostico,empleado, equipo, estudio, estudio_realizado, habitacion, internacion, obra_social, paciente, persona, tratamiento TO pradom_grupo_informes;


/*
Admisión
a) Agregar, modificar o eliminar un paciente.
b) Listar consultas, tratamientos, diagnósticos y estudios realizados de un determinado paciente.
c) Agregar consultas.
d) Agregar estudios realizados.
e) Listar, agregar, modificar internaciones.

*/
--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_admision WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo admision
CREATE ROLE pradom_admision WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_admision TO pradom_admision;

--concedemos permisos

-- a) eliminar un paciente
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE paciente TO pradom_grupo_admision; --creo que hara falta darle mas permisos para mantener la integridad referencial
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE persona TO pradom_grupo_admision; --creo que hara falta darle mas permisos para mantener la integridad referencial

--b)
GRANT SELECT ON TABLE tratamiento, estudio_realizado, diagnostico, consulta TO pradom_grupo_admision; -- le damos permiso en consulta para que pueda ver los diagnosticos de manera correcta

--c)
GRANT INSERT ON TABLE  consulta TO pradom_grupo_admision; 
GRANT SELECT(id_empleado) ON empleado TO pradom_grupo_admision;
--d))
GRANT INSERT ON TABLE  estudio_realizado TO pradom_grupo_admision; 

--e)
GRANT SELECT, INSERT, UPDATE ON TABLE  internacion TO pradom_grupo_admision; 

/*
RRHH
a) Agregar, modificar o eliminar empleados.
b) Modificar los datos de los empleados, especialidad, cargo, horarios que cumplen.
*/

--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_rrhh WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_rrhh WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_rrhh TO pradom_rrhh;

--asignacion de permisos

--a)
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE persona TO pradom_grupo_rrhh;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE empleado TO pradom_grupo_rrhh;

--b)
GRANT SELECT, UPDATE ON TABLE especialidad, cargo, trabajan, turno TO pradom_grupo_rrhh;


/*
Médicos
a) Agregar consultas.
b) Agregar, modificar o eliminar tratamientos.
c) Agregar, modificar o eliminar diagnósticos.
d) Agregar, modificar o eliminar estudios realizados.
e) Puede realizar todas las consultas que se realizan en Informes y Admisión.
*/

--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_medicos WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_medicos WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_medicos TO pradom_medicos;

--asignamos permisos

--a)
GRANT INSERT ON TABLE consulta TO pradom_grupo_medicos;

--b)
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE tratamiento TO pradom_grupo_medicos;

--c)
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE diagnostico TO pradom_grupo_medicos;

--d)
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE estudio_realizado TO pradom_grupo_medicos;

--e)
GRANT pradom_grupo_informes TO pradom_grupo_medicos;
GRANT pradom_grupo_admision TO pradom_grupo_medicos;


/*
Compras
a) Listar compras, mostrando proveedores, clasificación y laboratorio de cada insumo adquirido.
b) Agregar laboratorios, clasificaciones, proveedores y medicamentos.
c) Modificar laboratorios, clasificaciones, proveedores y medicamentos.	
d) Eliminar laboratorios, clasificaciones, proveedores y medicamentos.

*/
--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_compras WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_compras WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_compras TO pradom_compras;

--a)
GRANT SELECT ON TABLE compra TO pradom_grupo_compras
GRANT SELECT (id_proveedor, proveedor) ON proveedor TO pradom_grupo_compras -- no se si es necesario siempre dar el id_proveedor o cualquier id con el fin de poder hacer los join para ver el nombre del proveedor o simplemente con el nombre del proveedor ya puedo usar el id_proveedor sin mostrarlo
GRANT SELECT (id_medicamento, nombre, presentacion) ON medicamento TO pradom_grupo_compras
GRANT SELECT (id_laboratorio, laboratorio) ON laboratorio TO pradom_grupo_compras
GRANT SELECT (id_clasificacion, clasificacion) ON clasificacion TO pradom_grupo_compras

--b)Agregar laboratorios, clasificaciones, proveedores y medicamentos.
GRANT INSERT ON laboratorio, clasificacion, proveedor, medicamento TO pradom_grupo_compras

--c)Modificar laboratorios, clasificaciones, proveedores y medicamentos.	
GRANT UPDATE ON laboratorio, clasificacion, proveedor, medicamento TO pradom_grupo_compras

-- d) Eliminar laboratorios, clasificaciones, proveedores y medicamentos.
GRANT DELETE ON laboratorio, clasificacion, proveedor, medicamento TO pradom_grupo_compras

/*
Facturación
a) Listar las facturas, mostrando los pacientes.
b) Agregar, modificar y eliminar facturas.
c) Listar los pagos, mostrando el paciente.
d) Agregar modificar y eliminar pagos.
*/

--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_facturacion WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_facturacion WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_facturacion TO pradom_facturacion;

--a) Listar las facturas, mostrando los pacientes.
GRANT SELECT  ON persona TO pradom_grupo_facturacion
GRANT SELECT ON factura TO pradom_grupo_facturacion

--b) Agregar, modificar y eliminar facturas.
GRANT UPDATE, INSERT, DELETE ON factura TO pradom_grupo_facturacion

--c) Listar los pagos, mostrando el paciente.
GRANT SELECT ON pago TO pradom_grupo_facturacion -- el resto de permisos ya los tiene, puede hacer join con facturas para mostrar los pagos y luego el join con personas a traves de la id_persona para mostrar el paciente

--d) Agregar modificar y eliminar pagos.
GRANT UPDATE, INSERT, DELETE ON pago TO pradom_grupo_facturacion

/*
Mantenimiento
a) Listar los equipos y el estado de los mismos.
b) Listar las camas y el estado de las mismas.
c) Agregar nuevos equipos y camas
*/

--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_mantenimiento WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_mantenimiento WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_mantenimiento TO pradom_mantenimiento;

--a) Listar los equipos y el estado de los mismos.
GRANT SELECT ON equipo TO pradom_grupo_mantenimiento;
GRANT SELECT(id_equipo, fecha_ingreso, observacion, estado,fecha_egreso, demora) ON mantenimiento_equipo TO pradom_grupo_mantenimiento; --no usare el id_equipo con permiso de select para ver que pasa cuando hago el join!!!! definitivamente tengo que agregar el id_equipo sino no tengo acceso a ese campo para poder hacer el join y me salta el error de que no tengo permiso en la tabla mantenimiento_equipo por ende tengo que si o si ver que es lo que estoy usando en el join. Ademas tengo que ver bien que son las cosas que muestro que si no tengo acceso total a la tabla no puedo hacer SELECT * FROM tabla!!!! tengo que ver bien que son los campos que se nos pide mostrar (de todas formas el enunciado es muy pobre y no nos brinda aclaracion exacta de cual es el acceso que debe tener cada usuario!!)

--b) Listar las camas y el estado de las mismas.
GRANT SELECT ON cama, mantenimiento_cama TO pradom_grupo_mantenimiento;

--c) Agregar nuevos equipos y camas
GRANT INSERT ON cama, equipo TO pradom_grupo_mantenimiento
GRANT SELECT (id_habitacion, piso, numero, tipo) ON habitacion TO pradom_grupo_mantenimiento

SELECT * FROM cama INNER JOIN habitacion USING(id_habitacion)

/*
Sistemas
a) Agregar, modificar o eliminar estudios.
b) Agregar, modificar o eliminar cargos.
c) Agregar, modificar o eliminar especialidades.
d) Agregar, modificar o eliminar tipos de estudios.
e) Agregar, modificar o eliminar consultorios.
f) Agregar, modificar o eliminar obras sociales.
g) Agregar, modificar o eliminar turnos.
h) Listar todas las tablas antes mencionadas
*/

--creamos el grupo para luego crear los usuarios
CREATE ROLE pradom_grupo_sistemas WITH
NOLOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1;

--creamos el usuarios correspondiente para el grupo informes
CREATE ROLE pradom_sistemas WITH
LOGIN
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
INHERIT
NOREPLICATION
NOBYPASSRLS
CONNECTION LIMIT -1
PASSWORD '1234';

GRANT pradom_grupo_sistemas TO pradom_sistemas;

--a) Agregar, modificar o eliminar estudios.
GRANT INSERT, UPDATE, DELETE ON estudio TO pradom_grupo_sistemas
GRANT SELECT ON tipo_estudio TO pradom_grupo_sistemas

--b) Agregar, modificar o eliminar cargos.
GRANT SELECT, INSERT, UPDATE, DELETE ON cargo TO pradom_grupo_sistemas;

--c) Agregar, modificar o eliminar especialidades.
GRANT SELECT, INSERT, UPDATE, DELETE ON especialidad TO pradom_grupo_sistemas;

--d) Agregar, modificar o eliminar tipos de estudios.
GRANT SELECT, INSERT, UPDATE, DELETE ON tipo_estudio TO pradom_grupo_sistemas;

--e) Agregar, modificar o eliminar consultorios.
GRANT SELECT, INSERT, UPDATE, DELETE ON consultorio TO pradom_grupo_sistemas;

--f) Agregar, modificar o eliminar obras sociales.
GRANT SELECT, INSERT, UPDATE, DELETE ON obra_social TO pradom_grupo_sistemas;

--g) Agregar, modificar o eliminar turnos.
GRANT SELECT, INSERT, UPDATE, DELETE ON turno TO pradom_grupo_sistemas;

--h) Listar todas las tablas antes mencionadas
GRANT SELECT ON estudio, cargo, especialidad, tipo_estudio, consultorio, obra_social, turno TO pradom_grupo_sistemas;

-- EJERCICIO 2
/*
a) Muestre el nombre, apellido y la obra social de todos los pacientes (incluso de aquellos que no tienen
obra social).
*/

SELECT p.nombre, apellido, COALESCE(os.nombre, 'SIN OBRA SOCIAL' ) FROM persona p
INNER JOIN paciente ON id_paciente = id_persona
LEFT JOIN obra_social os USING(id_obra_social)
--pradom_grupos_informes, pradom_grupos_medicos
/*
b) Liste el nombre, apellido, cargo, especialidad y sueldo de todos los empleados activos
*/

SELECT nombre, apellido, cargo, especialidad, sueldo FROM PERSONA
INNER JOIN empleado ON id_persona = id_empleado
INNER JOIN especialidad USING (id_especialidad)
INNER JOIN cargo USING (id_cargo)
WHERE fecha_baja IS NULL
--pradom_grupos_rrhh

/*
c) Mostrar los tratamientos cuyo número de dosis sea mayor que 3, es decir, el nombre del
medicamento, presentación, clasificación y descripción del tratamiento
*/

SELECT m.nombre, presentacion, clasificacion, descripcion FROM tratamiento
INNER JOIN medicamento m USING (id_medicamento)
INNER JOIN clasificacion USING (id_clasificacion)
WHERE dosis > 3

--ninguno

/*
d) Mostrar todas las consultas realizadas en el primer trimestre del 2022 (muestre el nombre completo
del paciente y del médico).
*/

SELECT me.nombre AS nombre_medico, me.apellido AS apellido_medico, pa.nombre AS nombre_paciente, pa.apellido AS apellido_paciendo, fecha, hora, resultado, id_consultorio FROM consulta
INNER JOIN persona me ON me.id_persona = id_empleado
INNER JOIN persona pa ON pa.id_persona = id_paciente
WHERE fecha >= '2022-01-01' AND fecha <= '2022-03-31';
--pradom_grupos_informes, pradom_grupos_medicos
/*
e) Mostrar todas las facturas que han sido pagadas parcialmente
*/

SELECT * FROM factura
WHERE pagada = 'N' AND saldo <> monto AND id_factura NOT IN(

SELECT id_factura FROM factura f
WHERE saldo > 0 AND pagada = 'N')

/*
f) Mostrar todas las consultas que atendió el médico “ANGELA MENDOZA” ordenado por fecha y hora
*/

SELECT CONCAT(pac.apellido,', ', pac.nombre) AS paciente, CONCAT(emp.apellido, ' ', emp.nombre) AS medico, fecha, hora, resultado FROM consulta 
INNER JOIN empleado USING (id_empleado)
INNER JOIN persona emp ON emp.id_persona = id_empleado
INNER JOIN persona pac ON pac.id_persona = id_paciente
WHERE emp.nombre = 'ANGELA' AND emp.apellido = 'MENDOZA' 
ORDER BY fecha, hora
--pradom_grupos_informes, pradom_grupos_medicos, pradom_grupos_admision
/*
g) Mostrar la historia clínica de la paciente “SOFIA TELLO” (todas las consultas, tratamientos, estudios,
internaciones). Ordene los resultados por fecha.
*/

SELECT nombre, apellido, caracter, fecha, historico FROM persona
INNER JOIN (SELECT 'CONSULTA' AS caracter, id_paciente, resultado AS historico, fecha FROM consulta
			UNION
			SELECT 'ESTUDIO' AS caracter, id_paciente, CONCAT(observacion, ' - RESULTADO: ', resultado)AS historico, fecha FROM estudio_realizado
			UNION
			SELECT 'TRATAMIENTO' AS caracter, id_paciente, descripcion AS historico, fecha_indicacion AS fecha FROM tratamiento
			UNION
			SELECT 'INTERNACION' AS caracter, id_paciente, CONCAT('ALTA: ', fecha_alta)AS historico, fecha_inicio FROM internacion) AS tabla1 ON id_persona = tabla1.id_paciente
WHERE nombre = 'SOFIA' AND apellido = 'TELLO'
ORDER BY fecha
--pradom_grupos_admision, pradom_grupos_informes, pradom_grupos_medicos,
/*
h) Mostrar todos los pagos realizados por “SERGIO DANIEL PEREZ”
*/

SELECT * FROM facturacion.factura
INNER JOIN persona ON id_paciente = id_persona
INNER JOIN facturacion.pago USING(id_factura)
WHERE nombre = 'SERGIO DANIEL' AND apellido ='PEREZ'
--pradom_grupos_facturacion

/*
i) Listar todos los equipos que aún están en mantenimiento.
*/
SELECT fecha_ingreso, observacion, estado, demora FROM equipo
INNER JOIN mantenimiento_equipo USING (id_equipo)
WHERE fecha_egreso IS NULL

/*
j) Muestre todas las compras realizadas al laboratorio “ROEMMERS” indicando la fecha de compra, el
medicamento, el proveedor y el empleado que realizó la compra
*/
SELECT laboratorio, me.nombre, proveedor, fecha, concat(PE.nombre, ' ', PE.apellido) AS empleado FROM compra
INNER JOIN persona PE ON id_empleado = id_persona
INNER JOIN medicamento me USING(id_medicamento)
INNER JOIN proveedor USING(id_proveedor)
INNER JOIN laboratorio USING (id_laboratorio)
WHERE laboratorio LIKE 'ROEMMERS'

/*
k) Agregar un nuevo Laboratorio (206, “LABUNT”, “AV. INDEPENDENCIA 1800”, “54-381-123-5555”).
*/

START TRANSACTION;
INSERT INTO public.laboratorio(id_laboratorio, laboratorio, direccion, telefono)
VALUES (206,'LABUNT', 'AV. INDEPENDENCIA 1800', '54-381-123-5555');

SELECT * FROM laboratorio WHERE id_laboratorio = 206
ROLLBACK;

/*
l) Ingresar una cama a mantenimiento (52, “2023-02-02”, “A la espera de repuestos”, “En reparacion”,
null, 26, 210).
*/
START TRANSACTION;
INSERT INTO public.mantenimiento_cama(id_cama, fecha_ingreso, observacion, estado, fecha_egreso, demora, id_empleado)
VALUES (52, '2023-02-02', 'A la espera de repuestos', 'En reparacion', NULL, 26, 210);
ROLLBACK;

/*
m) Modificar el teléfono del laboratorio “LABUNT”, por el “54-381-456-5555”
*/
START TRANSACTION;
UPDATE public.laboratorio SET telefono='54-381-456-5555'
WHERE laboratorio = 'LABUNT';
ROLLBACK;

/*
n) El empleado “PABLO ALEJANDRO MEDRANO” pasa de trabajar los sábados a la mañana a los domingos
a la mañana
*/

SELECT * FROM trabajan
INNER JOIN persona ON id_persona = id_empleado
INNER JOIN turno USING(id_turno)
WHERE nombre LIKE 'PABLO ALEJANDRO' AND apellido = 'MEDRANO' AND fin IS NULL

START TRANSACTION
UPDATE trabajan SET  fin= CURRENT_DATE
FROM persona 
WHERE id_persona = id_empleado AND nombre LIKE 'PABLO ALEJANDRO' AND apellido = 'MEDRANO' AND fin IS NULL

INSERT INTO public.trabajan(id_turno, id_empleado, inicio)
VALUES (7, (SELECT id_persona FROM persona WHERE nombre LIKE 'PABLO ALEJANDRO' AND apellido = 'MEDRANO'), CURRENT_DATE);

ROLLBACK


/*
o) Eliminar el laboratorio “MERRELL”
*/

START TRANSACTION
DELETE FROM laboratorio WHERE laboratorio LIKE 'MERRELL'
ROLLBACK
SELECT * FROM turno

/*EJERCICIO 3*/
--a) Cree un nuevo esquema en la base de datos Hospital, con el nombre de “facturacion”.
CREATE SCHEMA facturacion AUTHORIZATION postgres;
--b) Mueva las tablas pago y factura al nuevo esquema “facturacion” (lo puede hacer desde la pestaña general de las propiedades de tabla).
ALTER TABLE pago SET SCHEMA facturacion
ALTER TABLE factura SET SCHEMA facturacion
--c) Conéctese al servidor con el usuario de facturación y realice nuevamente la consulta H. Explique si la pudo ejecutar y cómo lo hizo.
GRANT USAGE ON SCHEMA facturacion TO pradom_grupo_facturacion; -- ES NECESARIO PARA PODER USAR EL SCHEMA CON EL GRUPO FACTURACION