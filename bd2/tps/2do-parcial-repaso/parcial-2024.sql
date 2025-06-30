/*
Para mejorar y automatizar el funcionamiento de la base de datos “Hospital” realice las siguientes tareas:

a) Escriba una función que registre las altas de las compras de los medicamentos fn_compra, la misma recibirá como
parámetros el nombre del medicamento, el nombre del proveedor, el id del empleado, el precio y la cantidad a
comprada y un carácter. La fecha debe ser la del sistema, el precio y la cantidad no pueden ser negativos. La
función debe registrar las compras de los medicamentos, para facilitar el trabajo, cada vez que se pase el nombre
de un medicamento que figura más de una vez (tiene varias presentaciones) elija el primero que encuentre.
Una vez que se registre la compra, la función debe devolver un listado con el nombre del medicamento, cantidad,
fecha, precio, nombre del proveedor y dependiendo del carácter, si es ‘M’, todos los medicamentos comprados
con el mismo nombre, por otro lado, si el carácter es ‘P’ debe mostrar todos los medicamentos comprados a el
proveedor pasado por parámetro, si el carácter es cualquier otro, debe mostrar la compra de todos los
medicamentos, sin importar el proveedor ni el medicamento. Recuerde hacer las validaciones correspondientes.
Nota: se aconseja usar CREATE FUNCTION fn_compra (text, text, int, numeric, int, char) return … AS $$
*/

--CREAMOS LA FUNCION

CREATE OR REPLACE FUNCTION public.fn_compra(IN nombre_medicamento_p character varying, IN nombre_proveedor_p character varying, IN id_empleado_p integer, IN precio_p numeric, IN cantidad_p integer, IN caracter_p char)
    RETURNS SETOF parcial_pto1_2024
    LANGUAGE 'plpgsql'
    
AS $BODY$
BEGIN
	IF(nombre_medicamento_p IS NULL OR nombre_medicamento_p = '' OR nombre_proveedor_p IS NULL OR nombre_proveedor_p = '' OR id_empleado_p IS NULL OR precio_p IS NULL OR cantidad_p IS NULL) THEN
		RAISE EXCEPTION 'ERROR LOS PARAMETROS NO DEBEN SER CADENAS VACIAS NI NULOS';
	END IF;
	
	IF(precio_p <= 0 OR cantidad_p <= 0) THEN
		RAISE EXCEPTION 'ERROR EL PRECIO O LA CANTIDAD NO DEBEN SER NEGATIVOS!';
	END IF;

	INSERT INTO public.compra(id_medicamento, id_proveedor, fecha, id_empleado, precio_unitario, cantidad)
	VALUES ((SELECT id_medicamento FROM medicamento WHERE nombre = nombre_medicamento_p LIMIT 1), (SELECT id_proveedor FROM proveedor WHERE proveedor = nombre_proveedor_p), current_date, id_empleado_p, precio_p, cantidad_p);
	
	IF FOUND THEN
		RAISE NOTICE 'COMPRA DE MEDICAMENTO GUARDADA!';
	END IF;

	IF caracter_p = 'M' THEN
		RETURN QUERY SELECT nombre, cantidad, fecha, precio, proveedor FROM compra
		INNER JOIN medicamento USING(id_medicamento)
		INNER JOIN proveedor USING(id_proveedor)
		WHERE nombre = nombre_medicamento_p;
	ELSIF caracter_p = 'P' THEN
		RETURN QUERY SELECT nombre, cantidad, fecha, precio, proveedor FROM compra
		INNER JOIN medicamento USING(id_medicamento)
		INNER JOIN proveedor USING(id_proveedor)
		WHERE proveedor = nombre_proveedor_p;
	ELSE
		RETURN QUERY SELECT nombre, cantidad, fecha, precio, proveedor FROM compra
		INNER JOIN medicamento USING(id_medicamento)
		INNER JOIN proveedor USING(id_proveedor);
	END IF;
END;
$BODY$;

--TEST
select * from proveedor
select * from medicamento
ORDER BY ID_MEDICAMENTO ASC

select * from EMPLEADO

SELECT * FROM fn_compra('PANADOL MASTICABLE NINOS', 'QUIMICA SUIZA S.A.', 2, 993.31, 100, 'P')
select * from compra
order by fecha desc


ORDER BY nombre DESC

/*
EJERCICIO 2)

a) Cada vez que se realice una consulta, un estudio o una internación, se debe insertar un registro en una nueva tabla
llamada practicas_x_paciente, la misma tendrá los siguientes campos, id_paciente, nombre y apellido del paciente,
un campo ‘practica’, cantidad y fecha. Si en la tabla practicas_x_paciente existe un registro que contenga el
id_paciente y la practica (consulta, estudio o internación), deberá aumentar la cantidad en 1 y cambiar la fecha
por la del sistema.
*/

--creamos la tabla

CREATE TABLE public.practicas_x_paciente
(
    id_paciente integer NOT NULL,
    nombre character varying(100),
    apellido character varying(100),
    practica character varying(20) NOT NULL,
    cantidad smallint,
    fecha date
);

	
CREATE OR REPLACE FUNCTION public.aud_practicas()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
    
AS $BODY$
BEGIN
	IF tg_table_name = 'estudio_realizado' THEN
		IF(EXISTS (SELECT * FROM practicas_x_paciente WHERE id_paciente = new.id_paciente AND practica = 'ESTUDIO')) THEN
			UPDATE practicas_x_paciente
			SET 
				cantidad = cantidad + 1,
				fecha = current_date
			WHERE
				id_paciente = NEW.id_paciente AND
				practica = 'ESTUDIO';
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA actualizada A LA TABLA % POR PRACTICA DEL TIPO estudio', tg_table_name;
			END IF;
		ELSE
			INSERT INTO public.practicas_x_paciente(id_paciente, nombre, apellido, practica, cantidad, fecha)
			VALUES (NEW.id_paciente, (SELECT nombre FROM persona WHERE id_persona = NEW.id_paciente), (SELECT apellido FROM persona WHERE id_persona = NEW.id_paciente), 'ESTUDIO', 1, CURRENT_DATE);
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA agregada A LA TABLA % POR PRACTICA DEL TIPO estudio', tg_table_name;
			END IF;
		END IF;
	END IF;
	IF tg_table_name = 'internacion' THEN
		IF(EXISTS (SELECT * FROM practicas_x_paciente WHERE id_paciente = new.id_paciente AND practica = 'INTERNACION')) THEN
			UPDATE practicas_x_paciente
			SET 
				cantidad = cantidad + 1,
				fecha = current_date
			WHERE
				id_paciente = NEW.id_paciente AND
				practica = 'INTERNACION';
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA actualizada A LA TABLA % POR PRACTICA DEL TIPO internacion', tg_table_name;
			END IF;
		ELSE
			INSERT INTO public.practicas_x_paciente(id_paciente, nombre, apellido, practica, cantidad, fecha)
			VALUES (NEW.id_paciente, (SELECT nombre FROM persona WHERE id_persona = NEW.id_paciente), (SELECT apellido FROM persona WHERE id_persona = NEW.id_paciente), 'INTERNACION', 1, CURRENT_DATE);
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA agregada A LA TABLA % POR PRACTICA DEL TIPO internacion', tg_table_name;
			END IF;
		END IF;
	END IF;
	IF tg_table_name = 'consulta' THEN
			IF(EXISTS (SELECT * FROM practicas_x_paciente WHERE id_paciente = new.id_paciente AND practica = 'CONSULTA')) THEN
			UPDATE practicas_x_paciente
			SET 
				cantidad = cantidad + 1,
				fecha = current_date
			WHERE
				id_paciente = NEW.id_paciente AND
				practica = 'CONSULTA';
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA actualizada A LA TABLA % POR PRACTICA DEL TIPO consulta', tg_table_name;
			END IF;
		ELSE
			INSERT INTO public.practicas_x_paciente(id_paciente, nombre, apellido, practica, cantidad, fecha)
			VALUES (NEW.id_paciente, (SELECT nombre FROM persona WHERE id_persona = NEW.id_paciente), (SELECT apellido FROM persona WHERE id_persona = NEW.id_paciente), 'CONSULTA', 1, CURRENT_DATE);
			IF FOUND THEN
				RAISE NOTICE 'ENTRADA agregada A LA TABLA % POR PRACTICA DEL TIPO consulta', tg_table_name;
			END IF;
		END IF;
	END IF;
	RETURN NEW;
END;
$BODY$;

--creamos los triggers
CREATE OR REPLACE TRIGGER aud_practica
    AFTER INSERT
    ON public.estudio_realizado
    FOR EACH ROW
    EXECUTE FUNCTION public.aud_practicas();
	
CREATE OR REPLACE TRIGGER aud_practica
    AFTER INSERT
    ON public.consulta
    FOR EACH ROW
    EXECUTE FUNCTION public.aud_practicas();
	
CREATE OR REPLACE TRIGGER aud_practica
    AFTER INSERT
    ON public.internacion
    FOR EACH ROW
    EXECUTE FUNCTION public.aud_practicas();


--test
START TRANSACTION;
INSERT INTO public.estudio_realizado(id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
VALUES (14, 1, current_date, 1, 2, 'OK', 'ok2', 1000);

select * from estudio_borrado
order by fecha desc
select * FROM estudio_realizado
order by fecha DESC

INSERT INTO public.consulta(id_paciente, id_empleado, fecha, id_consultorio, hora, resultado)
VALUES (14, 2, current_date, 5, current_timestamp, 'OK');

INSERT INTO public.internacion(id_paciente, id_cama, fecha_inicio, ordena_internacion)
VALUES (14, 5, current_date, 2)
ROLLBACK;

--CONSULTAS PARA EL TEST
SELECT * FROM practicas_X_paciente
select * from paciente
select * from empleado
select * from paciente
select * from estudio
select * from cama
select * from consultorio
select * from consulta
select * from equipo

/*

b) Cada vez que se elimine una persona, se debe insertar un registro en una nueva tabla llamada personas_borradas,
la misma tendrá los siguientes campos, id de tipo serial, id_persona, nombre y apellido, dni y un campo en el cual
se indicará si la persona eliminada era empleado o paciente, la fecha, el usuario quien elimino a la persona.
 Nota: La función del trigger debe realizar todas las tareas necesarias (eliminar registros de las tablas que
 referencian a la persona elimina
*/

--CREAMOS LA TABLA

CREATE TABLE public.personas_borradas
(
    id_aud serial,
    user_aud character varying(100),
    fecha_aud time without time zone,
    id_persona integer,
    nombre character varying(100),
    apellido character varying(100),
    dni character varying(8),
    tipo_persona character varying(20)
);

--creamos la funcion que invocara el trigger
CREATE OR REPLACE FUNCTION public.personas_borradas()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	tipo_persona character varying;
BEGIN
	IF (EXISTS (SELECT id_paciente FROM paciente WHERE id_paciente = old.id_persona) AND EXISTS (SELECT id_empleado FROM empleado WHERE id_empleado = old.id_persona)) THEN
		call borrar_empleado_parcial(old.id_persona);
		call borrar_paciente_parcial(old.id_persona);
		tipo_persona := 'AMBOS';
	ELSIF EXISTS(SELECT id_persona FROM persona WHERE id_persona IN (SELECT id_empleado FROM empleado))THEN
		
		call borrar_empleado_parcial(old.id_persona);
		tipo_persona := 'EMPLEADO';
	ELSE
		call borrar_paciente_parcial(old.id_persona);
		tipo_persona := 'PACIENTE';
	
	END IF;
		INSERT INTO public.personas_borradas(id_aud, user_aud, fecha_aud, id_persona, nombre, apellido, dni, tipo_persona)
		VALUES (default, user, now()::timestamp(0), old.id_persona, (select nombre from persona where id_persona = old.id_persona), (select apellido from persona where id_persona = old.id_persona), (select dni from persona where id_persona = old.id_persona), tipo_persona);
	IF FOUND THEN
		RAISE NOTICE 'SE AGREGO UNA ENTRADA A LA TABLA personas_borradas';
	END IF;
	RETURN OLD;
END;
$BODY$;

CREATE OR REPLACE TRIGGER personas_borradas
    BEFORE DELETE
    ON public.persona
    FOR EACH ROW
    EXECUTE FUNCTION public.personas_borradas();

--test
start transaction;
select * from persona
select * from paciente order by id_paciente asc
delete from persona where id_persona = 30
select * from diagnostico where id_paciente =1
select * from personas_borradas 
SELECT id_persona FROM persona WHERE id_persona IN (SELECT id_empleado FROM empleado INTERSECT SELECT id_paciente FROM paciente) order by id_persona
rollback;

SELECT * FROM paciente
SELECT * FROM empleado