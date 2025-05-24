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
			RAISE EXCEPTION('no se pudo ejecutar por %', SQLERRM)
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
	IF ($1 IS NULL OR $1 = '') OR ($2 IS NULL OR $2 = '') OR ($3 IS NULL OR $3 = '') OR ($4 IS NULL OR $4 = '') OR ($5 IS NULL OR $5 = '') OR ($6 IS NULL OR $6 = '')  THEN
		RAISE EXCEPTION 'ERROR los datos ingresados no deben ser nulos o vacios';
	END IF;
		IF (EXTRACT(YEAR FROM fecha_nacimiento_n) < 2008) THEN
		RAISE EXCEPTION 'la persona que intenta cargar tiene que ser mayor de edad';
	END IF;
	--controlamos que la persona que queremos ingresar no este ya cargada
	IF EXISTS(SELECT dni FROM persona WHERE dni = dni_n) THEN
		RAISE EXCEPTION 'la persona que intenta cargar ya esta cargada';
	END IF;
	INSERT INTO persona(id_persona, nombre, apellido, dni, fecha_nacimiento, domicilio, telefono)
	VALUES((SELECT MAX(id_persona) + 1 FROM persona), nombre_n, apellido_n, dni_n, fecha_nacimiento_n, domicilio_n, telefono_n);
	RAISE NOTICE 'Cargado exitoso';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;


