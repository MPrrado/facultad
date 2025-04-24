/*
1)
*/
-- INFORMES
CREATE ROLE "pradom_group_informes" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_informes" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';
	
GRANT "pradom_group_informes" TO "pradom_user_informes"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_informes"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

-- DAMOS LOS PERMISOS NECESARIOS
-- a)

GRANT SELECT ON TABLE public.persona TO "pradom_group_informes";
GRANT SELECT ON TABLE public.paciente TO "pradom_group_informes";
GRANT SELECT ON TABLE public.obra_social TO "pradom_group_informes";

SELECT * FROM persona
INNER JOIN paciente ON id_paciente = id_persona
INNER JOIN obra_social USING (id_obra_social);


--b)

GRANT SELECT ON TABLE public.consulta TO "pradom_group_informes";
GRANT SELECT ON TABLE public.empleado TO "pradom_group_informes";
GRANT SELECT ON TABLE public.diagnostico TO "pradom_group_informes";
GRANT SELECT ON TABLE public.tratamiento TO "pradom_group_informes";

--c)

GRANT SELECT ON TABLE public.internacion TO "pradom_group_informes";
GRANT SELECT ON TABLE public.cama TO "pradom_group_informes";
GRANT SELECT ON TABLE public.habitacion TO "pradom_group_informes";

--d)

GRANT SELECT ON TABLE public.estudio_realizado TO "pradom_group_informes";
GRANT SELECT ON TABLE public.estudio TO "pradom_group_informes";
GRANT SELECT ON TABLE public.equipo TO "pradom_group_informes";

-- ADMISION

CREATE ROLE "pradom_group_admision" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_admision" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';
	
GRANT "pradom_group_admision" TO "pradom_user_admision"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_admision"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

--a)

GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.paciente TO "pradom_user_admision";
select * from paciente;

--b)

GRANT SELECT ON TABLE public.consulta TO "pradom_user_admision";
GRANT SELECT ON TABLE public.tratamiento TO "pradom_user_admision";
GRANT SELECT ON TABLE public.diagnostico TO "pradom_user_admision";
GRANT SELECT ON TABLE public.estudio_realizado TO "pradom_user_admision";

--c)

GRANT INSERT ON TABLE public.consulta TO "pradom_user_admision";

--d)

GRANT INSERT ON TABLE public.estudio_realizado TO "pradom_user_admision";

--e)

GRANT SELECT, UPDATE, INSERT ON TABLE public.internacion TO "pradom_user_admision";

-- RRHH

CREATE ROLE "pradom_group_rrhh" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_rrhh" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';
	
GRANT "pradom_group_rrhh" TO "pradom_user_rrhh"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_rrhh"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

--a)

GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.persona TO "pradom_user_rrhh";
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.empleado TO "pradom_user_rrhh";

--b)

GRANT SELECT, UPDATE ON TABLE public.especialidad TO "pradom_user_rrhh";
GRANT SELECT, UPDATE ON TABLE public.cargo TO "pradom_user_rrhh";
GRANT SELECT, UPDATE ON TABLE public.trabajan TO "pradom_user_rrhh";
GRANT SELECT, UPDATE ON TABLE public.turno TO "pradom_user_rrhh";

--MEDICOS

CREATE ROLE "pradom_group_medicos" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_medicos" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "pradom_group_medicos" TO "pradom_user_medicos"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_medicos"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

--a) 

GRANT SELECT, INSERT ON TABLE public.consulta TO "pradom_user_medicos";

--b)

GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.tratamiento TO "pradom_user_medicos";

--c)

GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.diagnostico TO "pradom_user_medicos";

--d)

GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE public.estudio_realizado TO "pradom_user_medicos";

--e)

GRANT "pradom_group_admision" TO "pradom_group_medicos"; -- con esta forma garantizamos que todo lo que puede hacer el grupo de informes y admision tambien lo pueda hacer el grupo medicocs
GRANT "pradom_group_informes" TO "pradom_group_medicos";

--COMPRAS

CREATE ROLE "pradom_group_compras" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_compras" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "pradom_group_compras" TO "pradom_user_compras"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_compras"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

--a)

GRANT SELECT ON TABLE public.proveedor TO "pradom_user_compras";
GRANT SELECT ON TABLE public.compra TO "pradom_user_compras";
GRANT SELECT ON TABLE public.medicamento TO "pradom_user_compras";
GRANT SELECT ON TABLE public.clasificacion TO "pradom_user_compras";
GRANT SELECT ON TABLE public.laboratorio TO "pradom_user_compras";

--b), c), d)

GRANT INSERT, UPDATE, DELETE ON TABLE public.laboratorio TO "pradom_user_compras";
GRANT INSERT, UPDATE, DELETE ON TABLE public.clasificacion TO "pradom_user_compras";
GRANT INSERT, UPDATE, DELETE ON TABLE public.proveedor TO "pradom_user_compras";
GRANT INSERT, UPDATE, DELETE ON TABLE public.medicamento TO "pradom_user_compras";

--FACTURACION


CREATE ROLE "pradom_group_facturacion" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_facturacion" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "pradom_group_facturacion" TO "pradom_user_facturacion"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_facturacion"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public


--a)

GRANT SELECT ON TABLE public.factura TO "pradom_user_facturacion";
GRANT SELECT ON TABLE public.persona TO "pradom_user_facturacion";
GRANT SELECT ON TABLE public.paciente TO "pradom_user_facturacion";

--b)

GRANT UPDATE, INSERT, DELETE ON TABLE public.factura TO "pradom_user_facturacion";

--c)

GRANT SELECT ON TABLE public.pago TO "pradom_user_facturacion";

--d)

GRANT INSERT, UPDATE, DELETE ON TABLE public.pago TO "pradom_user_facturacion";

-- MANTENIMIENTO

CREATE ROLE "pradom_group_mantenimiento" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_mantenimiento" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "pradom_group_mantenimiento" TO "pradom_user_mantenimiento"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_mantenimiento"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public


--a)

GRANT SELECT ON TABLE public.equipo TO "pradom_user_mantenimiento";
GRANT SELECT ON TABLE public.mantenimiento_equipo TO "pradom_user_mantenimiento";

--b)

GRANT SELECT ON TABLE public.cama TO "pradom_user_mantenimiento";
GRANT SELECT ON TABLE public.mantenimiento_cama TO "pradom_user_mantenimiento";

--c)

GRANT INSERT ON TABLE public.equipo TO "pradom_user_mantenimiento";
GRANT INSERT ON TABLE public.cama TO "pradom_user_mantenimiento";

-- SISTEMAS

CREATE ROLE "pradom_group_sistemas" WITH -- creamos el grupo mediante las herramientas del dbms
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
	
CREATE ROLE "pradom_user_sistemas" WITH -- creamos el usuario referido al grupo que necesitamos mediante las herramientas del d
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "pradom_group_sistemas" TO "pradom_user_sistemas"; -- agreamos el usuario al grupo

GRANT USAGE ON SCHEMA public TO "pradom_group_sistemas"; -- le damos permiso al grupo para acceder a los schemas, en este caso al public

--

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.estudio TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.cargo TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.especialidad TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.tipo_estudio TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.consultorio TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.obra_social TO "pradom_user_sistemas";
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.turno TO "pradom_user_sistemas";

-- ejercicio 2
--a)
-- esta consulta la puede hacer el usuario informes
SELECT p.nombre, apellido, os.nombre FROM persona p
INNER JOIN paciente ON id_paciente = id_persona
LEFT JOIN obra_social os USING (id_obra_social)

--b)

SELECT p.nombre, p.apellido, cargo, especialidad, sueldo FROM persona p
INNER JOIN empleado ON id_empleado = id_persona
INNER JOIN especialidad USING(id_especialidad)
INNER JOIN cargo USING(id_cargo)

--c)

SELECT m.nombre AS nombre_medicamento, m.presentacion, clasificacion, descripcion, dosis FROM tratamiento
INNER JOIN medicamento m USING(id_medicamento)
INNER JOIN clasificacion USING(id_clasificacion)
WHERE dosis > 3;

--d)
SELECT CONCAT(pe.apellido, ', ', pe.nombre) AS nombre_profesional, CONCAT(pp.apellido, ', ', pp.nombre) AS nombre_paciente, fecha, hora, resultado FROM consulta
INNER JOIN empleado USING (id_empleado)
INNER JOIN paciente USING(id_paciente)
INNER JOIN persona pe  ON id_empleado = pe.id_persona
INNER JOIN persona pp ON id_paciente = pp.id_persona
WHERE fecha BETWEEN '2022-01-01' AND '2022-03-31'

--e)
SELECT fecha, hora, monto, saldo FROM factura
WHERE saldo <> 0

--f)
SELECT CONCAT(apellido, ', ', nombre) AS doctor, fecha, hora, resultado FROM consulta
INNER JOIN empleado USING(id_empleado)
INNER JOIN persona ON id_empleado = id_persona
WHERE nombre = 'ANGELA' AND apellido = 'MENDOZA' 

--G)

SELECT p.nombre, p.apellido, tipo, fecha, informe FROM persona p
INNER JOIN paciente  ON id_persona = id_paciente
INNER JOIN (SELECT id_paciente, fecha, 'Estudio' AS tipo, CONCAT(e.nombre, ' - Resultado: ', resultado) AS informe FROM estudio_realizado
			INNER JOIN estudio e USING(id_estudio)
			UNION
			SELECT id_paciente, fecha_indicacion AS fecha, 'Tratamiento' AS tipo, m.nombre AS informe FROM tratamiento
			INNER JOIN medicamento m USING(id_medicamento)
			UNION
			SELECT id_paciente, fecha_inicio AS fecha, 'Internacion' AS tipo, CONCAT('Alta: ', fecha_alta) AS informe FROM internacion
			UNION
			SELECT id_paciente, fecha, 'Consulta' AS tipo, resultado AS informe FROM consulta
			) AS tabla USING(id_paciente)
WHERE p.nombre = 'SOFIA' AND p.apellido = 'TELLO'
ORDER BY fecha

--h)
SELECT nombre, apellido, p.monto, p.fecha  FROM persona
INNER JOIN paciente ON id_persona = id_paciente
INNER JOIN factura USING(id_paciente)
INNER JOIN pago p USING(id_factura)
WHERE nombre = 'SERGIO DANIEL' AND apellido = 'PEREZ'

--i)
SELECT * FROM mantenimiento_equipo
WHERE fecha_egreso IS null

--j)
SELECT p.nombre, p.apellido, proveedor, fecha, m.nombre FROM compra
INNER JOIN empleado USING(id_empleado)
INNER JOIN persona p ON id_persona = id_empleado
INNER JOIN proveedor USING(id_proveedor)
INNER JOIN medicamento m USING(id_medicamento)
WHERE proveedor LIKE '%ROEMMERS%'

START TRANSACTION
--k)
INSERT INTO laboratorio VALUES(206, 'LABUNT', 'AV. INDEPENDENCIA 1800', '54-381-123-5555');
select * from laboratorio
WHERE id_laboratorio = 206;
--l)
INSERT INTO mantenimiento_cama VALUES(52,'2023-02-02', 'A la espera de repuestos', 'En reparacion',null, 26, 210);

--M)
UPDATE laboratorio SET telefono = '54-381-456-5555'

--n)
UPDATE turno SET turno = 'Domingo'
SELECT * from persona
INNER JOIN empleado ON id_persona = id_empleado
INNER JOIN trabajan USING(id_empleado)
INNER JOIN turno USING(id_turno)
WHERE nombre = 'PABLO ALEJANDRO' AND apellido = 'MEDRANO'

ROLLBACK
DELETE FROM mantenimiento_cama
WHERE id_cama = 52 AND fecha_ingreso = '2023-02-02'