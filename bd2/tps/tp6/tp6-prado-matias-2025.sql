--a)
CREATE OR REPLACE PROCEDURE public.especialidad_alta(IN especialidad_nueva character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
especialidad_encontrada especialidad%ROWTYPE;
BEGIN
	IF especialidad_nueva IS NULL OR especialidad_nueva = '' THEN
		RAISE EXCEPTION 'ERROR el dato ingresado no debe ser nulo o vacio';
	END IF;
	IF EXISTS(SELECT especialidad FROM especialidad WHERE especialidad = especialidad_nueva) THEN
		RAISE EXCEPTION 'la especialidad que intenta cargar ya esta cargada';
	END IF;
	INSERT INTO especialidad(id_especialidad, especialidad)
	VALUES((SELECT MAX(id_especialidad) + 1 FROM especialidad), especialidad_nueva);
	RAISE NOTICE 'Cargado exitoso';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;
ALTER PROCEDURE public.especialidad_alta(character varying)
    OWNER TO postgres;

call especialidad_alta('PRADO'); -- funciona con todos los casos no hace falta comprobar la longitud que se cargue y se trunce solo

--b)

CREATE OR REPLACE PROCEDURE public.persona_alta(IN nombre_n character varying, IN apellido_n character varying, IN dni_n character varying, fecha_nacimiento_n date, domicilio_n character varying, telefono_n character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	--controlamos que no sean vacios o nulos los datos de entrada
	IF ($1 IS NULL OR $1 = '') OR ($2 IS NULL OR $2 = '') OR ($3 IS NULL OR $3 = '') OR  ($5 IS NULL OR $5 = '') OR ($6 IS NULL OR $6 = '')  THEN
		RAISE EXCEPTION 'ERROR los datos ingresados no deben ser nulos o vacios';
	END IF;
	IF(fecha_nacimiento_n IS NULL) THEN
		RAISE EXCEPTION 'ERROR: LA FECHA NO TIENE QUE SER NULA';
	END IF;
	IF (EXTRACT(YEAR FROM fecha_nacimiento_n) > 2008) THEN
		RAISE EXCEPTION 'ERROR: la persona que intenta cargar tiene que ser mayor de edad';
	END IF;
	--controlamos que la persona que queremos ingresar no este ya cargada
	IF EXISTS(SELECT dni FROM persona WHERE dni = dni_n) THEN
		RAISE EXCEPTION 'ERROR: la persona que intenta cargar ya esta cargada';
	END IF;
	INSERT INTO persona(id_persona, nombre, apellido, dni, fecha_nacimiento, domicilio, telefono)
	VALUES((SELECT MAX(id_persona) + 1 FROM persona), nombre_n, apellido_n, dni_n, fecha_nacimiento_n, domicilio_n, telefono_n);
	RAISE NOTICE 'Cargado exitoso';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'ERROR: no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;

--test 
call persona_alta('MATIAS SANTIAGO', 'PRADO', '44658689', '2003-02-14'::date, 'SANTA FE 2834', '54-381-582-5154');

select * from persona
ORDER BY id_persona DESC

CREATE OR REPLACE PROCEDURE public.empleado_alta_interno(IN especialidad_n character varying, IN cargo_n character varying,  sueldo_n numeric(9,2))
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	--controlamos que no sean vacios o nulos los datos de entrada
	IF (($1 IS NULL OR $1 = '') OR ($2 IS NULL OR $2 = '') OR ($3 IS NULL)) THEN
		RAISE EXCEPTION 'ERROR los datos ingresados no deben ser nulos o vacios';
	END IF;
	IF(NOT EXISTS(SELECT * FROM especialidad WHERE especialidad = especialidad_n)) THEN
		RAISE EXCEPTION 'ERROR: la especialidad ingresada no existe ';
	END IF;
	IF (NOT EXISTS(SELECT * FROM cargo WHERE cargo = cargo_n)) THEN
		RAISE EXCEPTION 'ERROR: el cargo ingresado no existe';
	END IF;
	INSERT INTO empleado(id_empleado, id_especialidad, id_cargo, fecha_ingreso, sueldo)
	VALUES((SELECT MAX(id_persona) FROM persona), (SELECT id_especialidad FROM especialidad WHERE especialidad = especialidad_n), (SELECT id_cargo FROM cargo WHERE cargo = cargo_n LIMIT 1), CURRENT_DATE, sueldo_n);
	RAISE NOTICE 'Cargado exitoso';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por xd %', SQLERRM;
END;
$BODY$;

--TESTEO
call empleado_alta_interno('CIRUGIA', 'DIRECTOR',100000.00)
select * from especialidad
select * from empleado
ORDER BY id_empleado DESC
select * from cargo

--ARMAMOS UN PROCEDIMIENTO PARA EJECUTAR REALMENTE EL ALTA DE UN EMPLEADO

CREATE OR REPLACE PROCEDURE public.empleado_alta(IN nombre_n character varying, IN apellido_n character varying, IN dni_n character varying, fecha_nacimiento_n date, domicilio_n character varying, telefono_n character varying, IN especialidad_n character varying, IN cargo_n character varying,  sueldo_n numeric(9,2))
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL persona_alta(nombre_n, apellido_n, dni_n, fecha_nacimiento_n, domicilio_n, telefono_n);
    CALL empleado_alta_interno(especialidad_n, cargo_n, sueldo_n);
	RAISE NOTICE 'Cargado exitoso';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;


-- testeo
CALL empleado_alta('MATIAS SANTIAGO', 'PRADO', '44658689', '2003-02-14', 'SANTA FE 2834', '54-381-582-5154', 'CIRUGIA', 'DIRECTOR', 1000000.00);

--c)

CREATE OR REPLACE PROCEDURE public.factura_modifica_saldo(IN numero_factura integer, IN monto_a_pagar numeric(10,2))
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF (NOT EXISTS(SELECT * FROM factura WHERE id_factura = numero_factura)) THEN
        RAISE EXCEPTION 'EL NUMERO DE FACTURA INGRESADO NO EXISTE';
    END IF;
	IF (SELECT pagada FROM factura WHERE id_factura = numero_factura) = 'S' THEN
		RAISE EXCEPTION 'LA FACTURA QUE QUIERE PAGAR NO POSEE DEUDA';
	END IF;
    IF (monto_a_pagar <= 0) THEN
        RAISE EXCEPTION 'EL MONTO A PAGAR TIENE QUE SER MAYOR A CERO';
    END IF;
    IF (SELECT saldo FROM factura WHERE id_factura = numero_factura) < monto_a_pagar THEN
        RAISE EXCEPTION 'EL MONTO A PAGAR NO DEBE EXCEDER LA DEUDA';
    END IF;
    IF (SELECT saldo - monto_a_pagar FROM factura WHERE id_factura = numero_factura) = 0 THEN
        UPDATE factura SET pagada = 'S' WHERE id_factura = numero_factura;
    END IF;
    UPDATE factura SET saldo = saldo - monto_a_pagar WHERE id_factura = numero_factura;
	RAISE NOTICE 'UPDATE EXISTOSO';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;

--testeo
CALL factura_modifica_saldo(1064155, 100000);

select * from factura 
order by id_factura desc


--d)
CREATE OR REPLACE PROCEDURE public.medicamento_cambia_precio(IN nombre_n character varying, IN letra character, IN porcentaje_n numeric(5,2))
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF (nombre_n IS NULL OR nombre_n = '') THEN
        RAISE EXCEPTION 'EL NOMBRE INGRESADO DEBE SER CORRECTO';
    END IF;
    IF (letra IS NULL OR letra = '') THEN
        RAISE EXCEPTION 'LA LETRA DE OPCION NO DEBE SER NULA O CADENA VACIA';
    END IF;
	IF ( letra = 'M') THEN
		IF(EXISTS(SELECT * FROM medicamento WHERE nombre = nombre_n)) THEN
			UPDATE FROM medicamento SET precio = precio * (porcentaje_n / 100)
			WHERE nombre = nombre_n
			RAISE NOTICE 'UPDATE EXISTOSO';		
	END IF;
	IF ( letra = 'L') THEN
		IF(EXISTS(SELECT * FROM medicamento 
		INNER JOIN laboratorio USING(id_laboratorio)
		WHERE laboratorio = nombre_n)) THEN
			UPDATE FROM medicamento SET precio = precio * (porcentaje_n / 100)
			
			RAISE NOTICE 'UPDATE EXISTOSO';		
	END IF;
	IF ( letra = 'M') THEN
		IF(EXISTS(SELECT * FROM medicamento WHERE nombre = nombre_n LIMIT 1)) THEN
			UPDATE FROM medicamento SET precio = precio * (porcentaje_n / 100)
			RAISE NOTICE 'UPDATE EXISTOSO';		
	END IF;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;