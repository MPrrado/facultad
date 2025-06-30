/*
a) Escriba el procedimiento almacenado sp_calcula_costo, el mismo recibirá como parámetros el id_paciente,
id_cama, fecha_inicio y fecha_alta. El procedimiento debe calcular el costo de la internación multiplicando la
cantidad de días por el precio de la habitación. Para facilitar el trabajo, no realice los controles de existencia de
pacientes, cama ni de fechas, solo haga el cálculo del total.
Nota1: se aconseja usar CREATE PROCEDURE sp_calcula_costo (int, int, date, date, out total Numeric) AS $$
Nota2: para calcular la cantidad de días puede usar dif:= EXTRACT(DAY FROM age(date(fecha2),date(fecha1)))
*/

CREATE OR REPLACE PROCEDURE public.sp_calcula_costo(IN id_paciente_p integer, IN id_cama_p integer, IN fecha_inicio_p date, IN fecha_alta_p date, OUT total numeric)
LANGUAGE 'plpgsql'
AS $$
DECLARE
	cantidad_dias integer;
	precio_habitacion_i numeric(8,2);
BEGIN
	cantidad_dias := EXTRACT(DAY FROM age(fecha_alta_p, fecha_inicio_p));
	
	SELECT precio INTO precio_habitacion_i FROM paciente
	INNER JOIN internacion USING(id_paciente)
	INNER JOIN cama USING(id_cama)
	INNER JOIN habitacion USING(id_habitacion)
	WHERE id_paciente = id_paciente_p AND id_cama = id_cama_p;

	total := cantidad_dias * precio_habitacion_i;
END;
$$;

--test
CALL sp_calcula_costo(26909	,70, date('2025-12-1'), date('2025-12-21'), null);

/*
b) Escriba el procedimiento almacenado sp_internacion; el mismo recibirá como parámetros el nombre y apellido
de un paciente, id_cama y una fecha. Si en la tabla internación no existe un registro con el paciente, la cama
ingresada y sin datos de la fecha de alta, deberá realizar un nuevo ingreso usando la fecha recibida como
parámetro, como fecha_inicio y todos los campos restantes se insertan en null. Por el contrario, si hay un registro
con el paciente, la cama y la fecha de alta no tiene datos, deberá modificar el registro de la siguiente manera:
el campo fecha de alta con la fecha ingresada, el campo hora con la hora del sistema y el campo costo deberá ser
calculado usando la sp_calcula_costo. Realice todos los controles, y tenga en cuenta que hay camas que están
fuera de servicio.
Nota1: se aconseja usar CREATE PROCEDURE sp_internacion(text, text, integer, date) AS $$
Nota2: se aconseja usar Variable = (SELECT sp_calcula_costo(arg1, arg2, arg3, arg4, NULL))
*/

CREATE OR REPLACE PROCEDURE public.sp_internacion(IN nombre_p character varying, IN apellido_p character varying, IN id_cama_p integer, IN fecha_p date)
LANGUAGE 'plpgsql'
AS $$
DECLARE
	total_internacion numeric(10,2);
	id_paciente_p integer;
	fecha_inicio_i date;
BEGIN
	IF (nombre_p IS NULL OR nombre_p = '' OR apellido_p IS NULL OR apellido_p ='' OR id_cama_p IS NULL OR fecha_p IS NULL) THEN
		RAISE EXCEPTION 'ERROR LOS PARAMETROS NO DEBEN SER NULOS NI CADENAS VACIAS';
	END IF;
	
	IF NOT EXISTS(SELECT id_paciente FROM paciente INNER JOIN persona ON id_paciente = id_persona WHERE nombre = nombre_p AND apellido = apellido_p) THEN
		RAISE EXCEPTION 'ERROR EL PACIENTE INGRESADO NO EXISTE';
	END IF;

	SELECT id_paciente INTO id_paciente_p FROM paciente INNER JOIN persona ON id_paciente = id_persona WHERE nombre = nombre_p AND apellido = apellido_p; --si llega aqui entonces si exite el paciente
	
	IF NOT EXISTS( SELECT * FROM internacion WHERE id_paciente = id_paciente_p AND id_cama = id_cama_p AND fecha_alta IS NULL) THEN
	
		IF ((SELECT estado FROM cama WHERE id_cama = id_cama_p ) != 'OK') THEN
			RAISE EXCEPTION 'ERROR LA CAMA INGRESADA NO ESTA DISPONIBLE PARA SU USO';
		END IF;
		
		INSERT INTO public.internacion(id_paciente, id_cama, fecha_inicio)
		VALUES (id_paciente_p, id_cama_p, fecha_p);

		IF FOUND THEN
			RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA INTERNACION';
		END IF;
	ELSE
		SELECT fecha_inicio INTO fecha_inicio_i FROM internacion WHERE id_paciente = id_paciente_p AND id_cama = id_cama_p AND fecha_alta IS NULL;
		
		call sp_calcula_costo (id_paciente_p, id_cama_p, fecha_inicio_i, fecha_p, total_internacion); -- no tengo que asignar simplemente mandar el parametro
		
		UPDATE internacion 
		set 
			fecha_alta = fecha_p,
			costo= total_internacion,
			hora = now()::timestamp(0)
		WHERE 
			id_paciente = id_paciente_p AND id_cama = id_cama_p;
		IF FOUND THEN
			RAISE NOTICE 'SE ACTUALIZO UNA ENTRADA EN LA TABLA INTERNACION';
		END IF;
	END IF;
	
END;
$$;


--test
select * from paciente
inner join persona on id_paciente = id_persona
where id_paciente = 61
select * from empleado
INSERT INTO public.internacion(
	id_paciente, id_cama, fecha_inicio, ordena_internacion)
	VALUES (61, 70, CURRENT_DATE, 29)
select * from internacion
where id_paciente = 61

select * from cama 
inner join habitacion using(id_habitacion)
where id_cama=70

call sp_internacion('FACUNDO', 'COLANTTI', 70, current_date); -- modificando temporalmente la tabla internacion para que acepte valores nulos de medicos que ordenen la internacion tambien funciona

/*
a) Cada vez que se inserte un registro en la tabla estudio_realizado, se debe insertar un registro en una nueva tabla
llamada estudios_x_empleados, la misma tendrá los siguientes campos, id_empleado, nombre y apellido del
empleado, el id y nombre del estudio que realizó y un campo cantidad, el cual guardará la cantidad de estudios
que realizó el empleado y la fecha en la que se realizó el estudio. Si en la tabla estudios_x_empleados existe un
registro que contenga el id_empleado y el id_estudio, deberá aumentar la cantidad de estudio en 1 y cambiar la
fecha por la del último estudio realizado, si no coincide alguno de los id, deberá insertar un nuevo registro con los
nuevos datos.
*/
--CREAMOS LA TABLA

CREATE TABLE public.estudios_x_empleados
(
    id_empleado integer,
    nombre_empleado character varying(100) NOT NULL,
    apellido_empleado character varying(100) NOT NULL,
    id_estudio integer,
    nombre_estudio character varying(100),
    cantidad integer,
    fecha_ultimo_estudio date,
    PRIMARY KEY (id_empleado, id_estudio)
);

--CREAMOS LA FUNCION
CREATE OR REPLACE FUNCTION public.fn_estudios_empleado()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	IF EXISTS (SELECT * FROM estudios_x_empleados WHERE id_empleado = new.id_empleado AND id_estudio = new.id_estudio) THEN
		UPDATE estudios_x_empleados 
		SET
			cantidad = cantidad + 1,
			fecha_ultimo_estudio = CURRENT_DATE
		WHERE 
			id_empleado = new.id_empleado AND
			id_estudio = new.id_estudio;
		IF FOUND THEN
			RAISE NOTICE 'SE ACTUALIZO UNA ENTRADA EN LA TABLA estudios_x_empleados';
		END IF;
	ELSE 
		INSERT INTO public.estudios_x_empleados(id_empleado, nombre_empleado, apellido_empleado, id_estudio, nombre_estudio, cantidad, fecha_ultimo_estudio)
		VALUES (new.id_empleado, (SELECT nombre FROM persona WHERE id_persona = new.id_empleado), (SELECT apellido FROM persona WHERE id_persona = new.id_empleado), new.id_estudio, (SELECT nombre FROM estudio WHERE id_estudio = new.id_estudio), 1, CURRENT_DATE);

		IF FOUND THEN
			RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA estudios_x_empleados';
		END IF;
	END IF;
	RETURN NEW;
END;
$BODY$;

--creamos el trigger
CREATE OR REPLACE TRIGGER estudios_empleados
    AFTER INSERT
    ON public.estudio_realizado
    FOR EACH ROW
    EXECUTE FUNCTION public.fn_estudios_empleado();

--test
INSERT INTO public.estudio_realizado(
	id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
	VALUES (70,38 , current_date, 7,50 , 'TEST' , 'OBSERVACION TEST', (SELECT precio FROM estudio WHERE id_estudio = 38));

INSERT INTO public.estudio_realizado(
	id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
	VALUES (99,39 , current_date, 7, 78, 'TEST' , 'OBSERVACION TEST', (SELECT precio FROM estudio WHERE id_estudio = 39));

--consultas para el test
select * from estudios_x_empleados
select * from paciente 
inner join persona on id_paciente = id_persona

select * from empleado
inner join persona on id_empleado = id_persona
where id_empleado = 50

select * from estudio_realizado
order by fecha DESC
where id_paciente = 43 AND id_estudio = 38
select * from estudio
where id_estudio = 152
select * from equipo


/*
b) Audite la tabla empleados solo cuando se modifique el campo sueldo por un sueldo mayor. Se debe guardar un
registro en la tabla audita_empleado. Los datos que debe almacenar la nueva tabla serán: id, usuario, la fecha
cuando se produjo la modificación, el id, nombre y apellido del empleado, el sueldo antes de la modificación y el
sueldo después de la modificación, además de un campo llamado porcentaje, que guardará el porcentaje de
aumento.
 Nota2: porcentaje = ((sueldo_aumentado - sueldo_sin_aumento) / sueldo_sin_aumento) * 100
*/


--creamos la tabla de auditacion
CREATE TABLE public.audita_empleados
(
    id_aud serial,
    usuario_aud character varying(100),
    fecha_aud timestamp without time zone,
    id_empleado integer,
    nombre character varying(100),
    apellido character varying(100),
    sueldo_anterior numeric(9, 2),
    sueldo_nuevo numeric(9, 2),
    porcentaje numeric(5, 2)
);

--CREAMOS LA FUNCION
CREATE OR REPLACE FUNCTION public.fn_audita_empleados()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	porcentaje numeric(5,2);
BEGIN
	porcentaje:= ((new.sueldo - old.sueldo) / old.sueldo) * 100;
	INSERT INTO public.audita_empleados(id_aud, usuario_aud, fecha_aud, id_empleado, nombre, apellido, sueldo_anterior, sueldo_nuevo, porcentaje)
	VALUES (default, user, now()::timestamp(0), old.id_empleado, (SELECT nombre FROM persona WHERE id_persona = old.id_empleado), (SELECT apellido FROM persona WHERE id_persona = old.id_empleado), old.sueldo, new.sueldo, porcentaje);
	IF FOUND THEN
		RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA audita_empleados';
	END IF;
	RETURN NEW;
END;
$BODY$;

--creamos el trigger
CREATE OR REPLACE TRIGGER audita_empleados
    AFTER UPDATE
    ON public.empleado
    FOR EACH ROW WHEN(old.sueldo < new.sueldo)
    EXECUTE FUNCTION public.fn_audita_empleados();

--TEST
UPDATE empleado SET sueldo = sueldo * 0.9
where id_empleado = 1

select * from audita_empleados
SELECT * FROM aud_empleado_sueldo
order by fecha_aud DESC
--CONSULTAS PARA AYUDARME EN EL TEST
SELECT * FROM empleado
SELECT * FROM estudios_x_empleados