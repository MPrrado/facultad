/*
a) Escriba una función que reciba como parámetros el nombre y apellido de un paciente, id_cama y una fecha. Si
existe un registro con el paciente y la cama ingresada, y no hay datos de la fecha_alta, deberá modificar la fecha
de alta con el valor ingresado. Por el contrario, si fecha_alta tiene dato almacenado, deberá realizar un nuevo
ingreso usando la fecha (recibida como parámetro) como fecha_inicio. Realice todos los controles, y tenga en
cuenta que hay camas que están fuera de servicio.
*/

CREATE OR REPLACE FUNCTION public.fn_pto1_parcial2022(IN nombre_paciente character varying, IN apellido_paciente character varying, IN id_cama_p integer, IN fecha_p date)
    RETURNS void
    LANGUAGE 'plpgsql'
    
AS $BODY$
DECLARE
	id_paciente_p integer;
BEGIN
	SELECT id_paciente INTO id_paciente_p FROM paciente 
	INNER JOIN persona ON id_paciente = id_persona 
	WHERE nombre = nombre_paciente AND apellido = apellido_paciente; --obtengo la id del paciente
	
	IF nombre_paciente IS NULL OR nombre_paciente = '' OR apellido_paciente IS NULL OR apellido_paciente = '' OR id_cama_p IS NULL OR fecha_P IS NULL THEN
		RAISE EXCEPTION 'ERROR: los datos ingresados no deben ser nulos ni cadenas vacias';
	END IF;
	
	IF id_paciente_p IS NULL THEN
		RAISE EXCEPTION 'ERROR: el paciente ingresado no existe en el sistema';
	
	END IF;
	
	IF (SELECT estado FROM cama WHERE id_cama = id_cama_p) != 'OK' THEN
		RAISE EXCEPTION 'ERROR: la cama ingresada no esta en condiciones para la internacion';
	END IF;

	IF EXISTS (SELECT * FROM internacion WHERE id_paciente = id_paciente_p AND id_cama = id_cama_p AND fecha_alta IS NULL) THEN
		UPDATE internacion
		SET
			fecha_alta = fecha_p
		WHERE
			id_paciente = id_paciente_p AND
			id_cama = id_cama_p;
		IF FOUND THEN
			RAISE NOTICE 'SE DIO DE ALTA EL PACIENTE %',(select CONCAT(nombre, ' ', apellido) FROM persona WHERE id_persona = id_paciente_p);
			RETURN;
		END IF;
	END IF;
	
	IF EXISTS (SELECT * FROM internacion WHERE id_paciente = id_paciente_p AND id_cama = id_cama_p AND fecha_alta IS NOT NULL) THEN
		INSERT INTO public.internacion(id_paciente, id_cama, fecha_inicio)
		VALUES (id_paciente_p, id_cama_p, fecha_p);
		IF FOUND THEN
			RAISE NOTICE 'SE INTERNO AL PACIENTE % EN LA CAMA %',(select CONCAT(nombre, ' ', apellido) FROM persona WHERE id_persona = id_paciente_p), id_cama_p;
			RETURN;
		END IF;
	END IF;
END;
$BODY$;

select * from cama
select * from PERSONA
WHERE ID_PERSONA = 26909
select * from cama
select * FROM fn_pto1_parcial2022('MABEL ELISABETH', 'BUSTOS', 70, CURRENT_DATE);
SELECT * FROM INTERNACION
order by fecha_inicio DESC
WHERE FECHA_ALTA IS NULL

/*
b) Escriba una función para listar los registros de las tablas clasificaciones o laboratorio. La función recibirá el nombre
de la tabla y el nombre de la clasificación o laboratorio, según corresponda. La función deberá mostrar un listado
de todos los medicamentos que pertenecen a dicha clasificación o laboratorio. El listado debe tener el id, nombre,
presentación y precio del medicamento, además de id y nombre del laboratorio o clasificación, según corresponda.
*/

--creamos tipo de datos que nos sirve para retorno de la funcion
CREATE TYPE public.dato_p2_parcial_2022 AS
(
	id_medicamento integer,
	nombre character varying,
	presentacion character varying,
	precio numeric(8, 2),
	id_lab_or_clas smallint,
	lab_or_class character varying
);


CREATE OR REPLACE FUNCTION public.fn_pto2_parcial2022(IN nombre_tabla character varying, IN nombre_p character varying)
    RETURNS SETOF dato_p2_parcial_2022
    LANGUAGE 'plpgsql'
    
AS $BODY$
DECLARE
BEGIN
	IF (nombre_tabla IS NULL OR nombre_tabla = '' OR nombre_p IS NULL OR nombre_p = '') THEN
		RAISE EXCEPTION 'ERROR: los parametros no deben ser nuelos o cadenas vacias';
	END IF;

	IF (LOWER(nombre_tabla) = 'clasificacion') THEN
		RETURN QUERY	SELECT id_medicamento, nombre, presentacion, precio, id_clasificacion AS id_lab_or_clas, clasificacion AS lab_or_clas FROM medicamento
						INNER JOIN clasificacion USING(id_clasificacion)
						WHERE clasificacion = nombre_p;
	END IF;

	IF (LOWER(nombre_tabla) = 'laboratorio') THEN
		RETURN QUERY	SELECT id_medicamento, nombre, presentacion, precio, id_laboratorio AS id_lab_or_clas, laboratorio AS lab_or_clas FROM medicamento
						INNER JOIN laboratorio USING(id_laboratorio)
						WHERE laboratorio = nombre_p;
	END IF;
END;
$BODY$;



--test
SELECT * FROM fn_pto2_parcial2022('clasificacion', 'ANALGESICO ANTINEURITICO');

select * from clasificacion
select * from laboratorio


/*
c) Escriba una función que reciba como parámetros el nombre y presentación de un medicamento y un porcentaje
de modificación de precio. Si el porcentaje ingresado es positivo, debe aumentar el precio, por lo contrario, si el
valor es negativo debe realizar un descuento. En caso de ser 0, se debe modificar el precio, en un 15%, de todos
los medicamentos que sean producidos por el mismo laboratorio que el medicamento ingresado como parámetro.
La función debe devolver un listado con el id, nombre presentación, precio y nombre del laboratorio que lo
produce.
*/

--creamos el tipo de datos que nos permite retornar correctamente los datos de la funcion
CREATE TYPE public.dato_p3_parcial_2022 AS
(
	id_medicamento integer,
	nombre_medicamento character varying,
	presentacion character varying,
	precio numeric(8, 2),
	laboratorio character varying
);



--test
start transaction
SELECT * FROM fn_pto3_parcial2022('ACETAM GOTAS','FRASCO X 10 ML',10);
rollback;
select * from medicamento

/*
EJERCICIO 2
a) Cada vez que se modifique la tabla internación, sólo si se modifica la fecha de alta, debe calcular el campo
costo como la cantidad de días por el costo de la habitación. Se recomienda usar “EXTRACT(DAY FROM
age(date(fecha_b),date(fecha_a))” para calcular la cantidad de días de internación. Debe enviar un mensaje
con el nombre del paciente, la cantidad de días que estuvo internado y el costo de dicha internación.
*/

CREATE OR REPLACE FUNCTION public.trigger_pto_2a()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
    
AS $BODY$
DECLARE
	cantidad_dias integer;
	precio_cama numeric;
	monto_internacion numeric;
	nombre_paciente character varying;
BEGIN
	cantidad_dias := EXTRACT(DAY FROM AGE(date(new.fecha_alta), date(old.fecha_inicio)));
	
	SELECT precio INTO precio_cama FROM cama --obtenemos el precio de la cama
	INNER JOIN habitacion USING (id_habitacion)
	WHERE id_cama = old.id_cama;

	monto_internacion := cantidad_dias * precio_cama;

	SELECT nombre INTO nombre_paciente FROM persona WHERE id_persona = old.id_paciente;
	RAISE NOTICE 'El paciente % fue dado de alta. Cantidad dias internado: % Costo internacion: %', nombre_paciente, cantidad_dias, monto_internacion;
	RETURN OLD;
END;
$BODY$;

--trigger
CREATE OR REPLACE TRIGGER trigger_pto_2a
    BEFORE UPDATE OF fecha_alta
    ON public.internacion
    FOR EACH ROW
    EXECUTE FUNCTION public.trigger_pto_2a();

--test
start transaction
	INSERT INTO public.internacion(id_paciente, id_cama, fecha_inicio, ordena_internacion)
	VALUES (1, 70, CURRENT_DATE, 4);

	UPDATE internacion set fecha_alta = '2025-06-30' WHERE id_paciente = 1 AND id_cama = 70 AND fecha_alta IS NULL
SELECT * FROM EMPLEADO
SELECT * FROM INTERNACION
ORDER BY fecha_inicio DESC
rollback;


-- Función para listar medicamentos por clasificación o laboratorio
-- NO se usa un tipo de dato predefinido para el retorno
CREATE OR REPLACE FUNCTION public.fn_pto2_parcial2022_no_type(
    IN nombre_tabla character varying,
    IN nombre_p character varying
)
RETURNS setof record -- Aquí se devuelve 'record' genérico
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    -- No se declara 'fila' con un tipo específico, ya que no existe
    fila record;
BEGIN
    IF (nombre_tabla IS NULL OR nombre_tabla = '' OR nombre_p IS NULL OR nombre_p = '') THEN
        RAISE EXCEPTION 'ERROR: los parametros no deben ser nulos o cadenas vacías';
    END IF;

    IF (LOWER(nombre_tabla) = 'clasificacion') THEN
        FOR fila IN SELECT m.id_medicamento, m.nombre, m.presentacion, m.precio, c.id_clasificacion AS id_lab_or_clas, c.clasificacion AS lab_or_clas
                     FROM medicamento m
                     INNER JOIN clasificacion c USING(id_clasificacion)
                     WHERE c.clasificacion = nombre_p LOOP
            RETURN NEXT fila;
        END LOOP;
        RETURN;

    ELSIF (LOWER(nombre_tabla) = 'laboratorio') THEN
        RETURN QUERY SELECT m.id_medicamento, m.nombre, m.presentacion, m.precio, l.id_laboratorio AS id_lab_or_clas, l.laboratorio AS lab_or_clas
                     FROM medicamento m
                     INNER JOIN laboratorio l USING(id_laboratorio)
                     WHERE l.laboratorio = nombre_p;
    ELSE
        RAISE EXCEPTION 'ERROR: El nombre de tabla "%" no es válido. Debe ser "clasificacion" o "laboratorio".', nombre_tabla;
    END IF;

END;
$BODY$;

-- **La consulta de prueba que daría el error (igual que antes):**
-- SELECT * FROM fn_pto2_parcial2022_no_type('clasificacion', 'ANALGESICO ANTINEURITICO');

-- **La forma correcta de llamar a esta función sin un tipo predefinido:**
-- (Necesitas especificar las columnas en la cláusula FROM)
SELECT
    id_medicamento,
    nombre,
    presentacion,
    precio,
    id_lab_or_clas,
    lab_or_class
FROM fn_pto2_parcial2022_no_type('clasificacion', 'ANALGESICO ANTINEURITICO')
AS (
    id_medicamento integer,
    nombre character varying,
    presentacion character varying,
    precio numeric(8, 2),
    id_lab_or_clas smallint,
    lab_or_class character varying
);

-- Si la llamas así, ¡funcionaría!
