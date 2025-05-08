

	ALTER TABLE tratamiento 
	ALTER COLUMN dosis TYPE smallint USING dosis::smallint -- es necesario pues no hay compatibilidad de texto a int

	EXPLAIN ANALYZE SELECT * FROM factura
	WHERE fecha BETWEEN '2021-01-01' AND '2021-03-31'; -- 1070ms after index: 922.459 159.139 mejora 85,1%

	CREATE INDEX idx_fecha_factura ON factura(fecha)
	


	SELECT  pg_size_pretty(pg_table_size('factura')) AS tamFactura,
	pg_size_pretty(pg_table_size('idx_fecha_factura')) AS tamIndiceFactura -- aqui puedo obtener solamente el tamaño del indice creado
	
	SELECT  pg_size_pretty(pg_table_size('factura')) AS tamFactura,
	pg_size_pretty(pg_indexes_size('factura')) AS tamIndiceFactura -- aqui puedo obtener solamente el tamaño de los indices de la tabla factura
	

	CREATE INDEX idx_persona_apellido_nombre ON persona(apellido,nombre)
	CREATE INDEX idx_persona_dni ON persona(dni)
	
	
	CREATE INDEX idx_factura_fecha ON factura(fecha)

	CREATE INDEX idx_medicamento_nombre ON medicamento(nombre)

	CREATE INDEX idx_empleado_fecha_baja ON empleado(fecha_baja)
	SELECT * FROM empleado
	order by nombre;
	ORDER BY piso;
	
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


	--a)
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