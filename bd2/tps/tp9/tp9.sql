/*
a) Auditoría de facturas: realice auditoria sobre la tabla factura para todas las acciones que
se realicen sobre la misma, guarde los registro en la tabla audita_factura cuyos campos
serán: id (serial), usuario, fecha, y todos los campos de la tabla factura. Realice la auditoria
de todas las acciones con una sola función.
*/

--creamos la tabla donde se guardaran las tablas truncadas

CREATE TABLE public.truncate_tables
(
    id serial,
    fecha_aud timestamp without time zone,
    usuario_aud character varying(100),
    nombre_tabla character varying(100),
    operacion character varying(50),
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.truncate_tables
    OWNER to postgres;

--creamos tabla de auditoria
CREATE TABLE public.aud_factura
(
    id_factura_aud serial,
    usuario_aud character varying(100),
    fecha_aud timestamp,
	tipo_operacion character varying(20),
    id_factura bigint,
    id_paciente integer,
    fecha date,
    hora time without time zone,
    monto numeric(10, 2),
    pagada character(10),
    saldo numeric(10, 2),
    PRIMARY KEY (id_factura_aud)
);

ALTER TABLE IF EXISTS public.aud_factura
    OWNER to postgres;
	
-- funcion que se activa con las operaciones que pueden ejecutar los trigger row x row
CREATE OR REPLACE FUNCTION public.aud_factura_abm()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    if (tg_op = 'DELETE') then
	insert into aud_factura values (default, user, now()::timestamp(0), 'DELETE', OLD.id_factura,
	(select id_paciente from paciente where id_paciente = old.id_paciente), old.fecha, old.hora, old.monto, old.pagada, old.saldo);
	raise notice 'se agrego una entrada a la tabla aud_factura por la operacion DELETE';
	return old;
	elsif (tg_op = 'INSERT') then
	insert into aud_factura values (default, user, now()::timestamp(0), 'DELETE', OLD.id_factura,
	(select id_paciente from paciente where id_paciente = old.id_paciente), old.fecha, old.hora, old.monto, old.pagada, old.saldo);
	raise notice 'se agrego una entrada a la tabla aud_factura por la operacion INSERT';
	return new;
	elsif (tg_op = 'UPDATE') then
	insert into aud_factura values (default, user, now()::timestamp(0), 'UPDATE - ANTES', OLD.id_factura,
	(select id_paciente from paciente where id_paciente = old.id_paciente), old.fecha, old.hora, old.monto, old.pagada, old.saldo);
insert into aud_factura values (default, user, now()::timestamp(0), 'UPDATE - DESPUES', new.id_factura,
	(select id_paciente from paciente where id_paciente = old.id_paciente), new.fecha, new.hora, new.monto, new.pagada, new.saldo);
	raise notice 'se agrego una entrada a la tabla aud_factura por la operacion UPDATE';
	return new; -- return old; en este caso se puede retornar cualquiera de las dos variables (solo una, no ambas)
	end if;
END;
$$;

-- trigger para las funciones que funcionan row x row
create trigger aud_factura_abm
after insert or delete or update on factura
for each row execute procedure aud_factura_abm();

--test
select * from factura
order by fecha desc

update factura set monto = 111111
where id_factura = 233735

select * from aud_factura
order by fecha desc

--funcion que ejecutara mi trigger por statement para cuando se trunce
CREATE OR REPLACE FUNCTION public.aud_truncate()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    if (tg_op = 'TRUNCATE') then
	insert into truncate_tables values (default,now()::timestamp(0), user, tg_table_name, 'TRUNCATE' );
	RAISE NOTICE 'se agrego una entrada a la taba truncate_tables sobre la tabla %', tg_table_name;
	end if;
	return NULL;
END;
$$;

--trigger para el truncate
create trigger aud_factura_truncate
after truncate on factura
for statement execute procedure aud_truncate();

--test 
start transaction
truncate pago, factura
select * from factura
select * from truncate_tables
rollback;

/*
b) Auditoría de empleados: realice la auditoría sobre la tabla empleados solo cuando se
produzca una modificación en el sueldo, cualquier otra operación debe ser ignorada por
esta auditoría.
Debe guardar los datos en una tabla llamada audita_empleado_sueldo cuyos campos
serán: id (serial), usuario, fecha, id_empleado, dni, nombre y apellido del empleado,
también debe tener un campo sueldo_viejo (sueldo antes de modificar), sueldo_nuevo
(sueldo después de modificar), un campo porcentaje que llevará la diferencia entre el
sueldo anterior y el nuevo expresado en porcentaje, y un campo estado, en el cual se
guardará “aumento”, si el sueldo nuevo es mayor al anterior o “descuento” en caso
contrario.
*/

CREATE TABLE public.aud_empleado_sueldo
(
    id_aud bigserial,
    usuario_aud character varying(100),
    fecha_aud timestamp without time zone,
    id_empleado integer,
    nombre_empleado character varying(100),
    apellido_empleado character varying(100),
    dni character varying(8),
    sueldo_nuevo numeric(9, 2),
    sueldo_viejo numeric(9, 2),
    porcentaje numeric(5, 2),
	caracter character varying(20),
    PRIMARY KEY (id_aud)
);

ALTER TABLE IF EXISTS public.aud_empleado_sueldo
    OWNER to postgres;
	
CREATE OR REPLACE FUNCTION public.aud_sueldo_empleado()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
	porcentaje numeric(5,2);
	nombre_empleado character varying(100);
	apellido_empleado character varying(100);
	dni_empleado character varying(8);
	caracter_cambio_sueldo character varying(20);
BEGIN
	porcentaje := abs(((old.sueldo-new.sueldo)*100) / old.sueldo);
	
	SELECT nombre INTO nombre_empleado FROM empleado INNER JOIN persona on id_empleado = id_persona
	WHERE id_empleado = old.id_empleado;
	
	SELECT apellido INTO apellido_empleado FROM empleado INNER JOIN persona on id_empleado = id_persona
	WHERE id_empleado = old.id_empleado;
	
	SELECT dni INTO dni_empleado FROM empleado INNER JOIN persona on id_empleado = id_persona
	WHERE id_empleado = old.id_empleado;
	
	IF new.sueldo < old.sueldo THEN
		caracter_cambio_sueldo:= 'DESCUENTO';
	END IF;
	IF new.sueldo > old.sueldo THEN
		caracter_cambio_sueldo:= 'AUMENTO';
	END IF;
		
	
	insert into aud_empleado_sueldo values (default,user,now()::timestamp(0),old.id_empleado, nombre_empleado, apellido_empleado, dni_empleado, new.sueldo, old.sueldo, porcentaje, caracter_cambio_sueldo);
	RAISE NOTICE 'se agrego una entrada a la tabla aud_empleado_sueldo';
	return NULL;
END;
$$;

create trigger aud_sueldo_empleado
after update on empleado
for each row when(old.sueldo != new.sueldo) execute procedure aud_sueldo_empleado();

--test
select * from empleado 
order by id_empleado DESC

UPDATE empleado SET sueldo = sueldo * 0.8
where id_empleado = 996;

UPDATE empleado SET sueldo = sueldo * 1.65
where id_empleado = 996;

UPDATE empleado SET sueldo = sueldo * 0.77
where id_empleado = 996;

select * from aud_empleado_sueldo


/*
c) Auditoría de tablas: audite la eliminación de registros de las tablas estudio_realizado,
consulta y tratamiento. Ante cualquier otra acción en estas tablas, esta auditoría no se
debe ejecutar.
Debe guardar los datos en una nueva tabla llamada audita_tablas_sistema cuyos campos
serán: id (serial), usuario y fecha, el id del paciente, la fecha en la que se realizó la
consulta, estudio o tratamiento y el nombre de la tabla a la que corresponde el registro
borrado.
Además, debe guardar el registro borrado en una tabla llamada estudio_borrado,
consulta_borrada o tratamiendo_borrado, según corresponda, los campos de estas tablas
serán los mismos que los de las tablas originales.

*/

--creamos la tabla audita_tablas_sistema
CREATE TABLE public.audita_tablas_sistema
(
    id_aud serial,
    usuario_aud character varying(100),
    fecha_aud timestamp without time zone,
    id_paciente integer,
    fecha date,
    nombre_tabla character varying(100)
);

ALTER TABLE IF EXISTS public.audita_tablas_sistema
    OWNER to postgres;

--creamos las tablas para almacenar las tuplas eliminadar
CREATE TABLE public.estudio_borrado
(
    id_paciente integer NOT NULL,
    id_estudio smallint NOT NULL,
    fecha date NOT NULL,
    id_equipo smallint NOT NULL,
    id_empleado integer NOT NULL,
    resultado character varying(50),
    observacion character varying(100),
    precio numeric(10, 2),
    PRIMARY KEY (id_paciente, id_estudio, fecha)
);

ALTER TABLE IF EXISTS public.estudio_borrado
    OWNER to postgres;


CREATE TABLE public.consulta_borrada
(
    id_paciente integer NOT NULL,
    id_empleado integer NOT NULL,
    fecha date NOT NULL,
    id_consultorio smallint,
    hora time without time zone,
    resultado character varying(100),
    PRIMARY KEY (id_paciente, id_empleado, fecha)
);

ALTER TABLE IF EXISTS public.consulta_borrada
    OWNER to postgres;


CREATE TABLE public.tratamiento_borrado
(
    id_paciente integer,
    id_medicamento integer,
    fecha_indicacion date,
    prescribe integer,
    nombre character varying(50),
    descripcion character varying(100),
    dosis smallint,
    costo numeric(10, 2)
);

ALTER TABLE IF EXISTS public.tratamiendo_borrado
    OWNER to postgres;

CREATE OR REPLACE FUNCTION public.aud_tablas_tratamiento_estudio_consulta()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
	IF (tg_table_name = 'tratamiento') THEN
		INSERT INTO audita_tablas_sistema(id_aud, usuario_aud, fecha_aud, id_paciente, fecha, nombre_tabla)
		VALUES(DEFAULT, USER, now()::timestamp(0), old.id_paciente, old.fecha_indicacion, 'TRATAMIENTO');

		--insertamos en la tabla de tuplas borradas la que se borro
		INSERT INTO public.tratamiento_borrado(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
		VALUES (old.id_paciente, old.id_medicamento, old.fecha_indicacion, old.prescribe, old.nombre, old.descripcion, old.dosis, old.costo);
		IF FOUND THEN
			RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA "audita_tablas_sistemas" y en la tabla "tratamiento_borrado"';
		END IF;
		RETURN old;
	END IF;
	
	IF (tg_table_name = 'consulta') THEN
		INSERT INTO audita_tablas_sistema(id_aud, usuario_aud, fecha_aud, id_paciente, fecha, nombre_tabla)
		VALUES(DEFAULT, USER, now()::timestamp(0), old.id_paciente, old.fecha, 'CONSULTA');

		--insertamos en la tabla de tuplas borradas la que se borro
		INSERT INTO public.consulta_borrada(id_paciente, id_empleado, fecha, id_consultorio, hora, resultado)
		VALUES (old.id_paciente, old.id_empleado, old.fecha, old.id_consultorio, old.hora, old.resultado);
		IF FOUND THEN
			RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA "audita_tablas_sistemas" y en la tabla "consulta_borrada"';
		END IF;
		RETURN old;
	END IF;
	
	IF (tg_table_name = 'estudio_realizado') THEN
		INSERT INTO audita_tablas_sistema(id_aud, usuario_aud, fecha_aud, id_paciente, fecha, nombre_tabla)
		VALUES(DEFAULT, USER, now()::timestamp(0), old.id_paciente, old.fecha, 'ESTUDIO');

		--insertamos en la tabla de tuplas borradas la que se borro
		INSERT INTO public.estudio_borrado(id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
		VALUES (old.id_paciente, old.id_estudio, old.fecha, old.id_equipo, old.id_empleado, old.resultado, old.observacion, old.precio);
		IF FOUND THEN
			RAISE NOTICE 'SE AGREGO UNA ENTRADA EN LA TABLA "audita_tablas_sistemas" y en la tabla "estudio_borrado"';
		END IF;
		RETURN old;
	END IF;
END;
$$;

create trigger aud_consulta
after delete on consulta
for each row execute procedure aud_tablas_tratamiento_estudio_consulta();

create trigger aud_tratamiento
after delete on tratamiento
for each row execute procedure aud_tablas_tratamiento_estudio_consulta();

create trigger aud_estudio
after delete on estudio_realizado
for each row execute procedure aud_tablas_tratamiento_estudio_consulta();

--test

select * from estudio_realizado
order by fecha DESC

select * from tratamiento
order by fecha_indicacion DESC

select * from consulta
order by fecha DESC

start transaction;

delete from estudio_realizado 
where id_estudio = 108 AND fecha = '2022-03-28' AND id_paciente = 87752

delete from tratamiento
where fecha_indicacion = '2025-06-11' AND id_paciente = 1

delete from diagnostico
where fecha = '2022-03-28' AND id_empleado = 364 AND id_paciente = 86416

delete from consulta
where fecha = '2022-03-28' AND id_empleado = 364 AND id_paciente = 86416



rollback;

select * from audita_tablas_sistema
select * from estudio_borrado
select * from consulta_borrada
select * from tratamiento_borrado

/*
d) Auditoría de personas: audite cada vez que se elimine una persona, en tal caso, se debe
insertar un registro en una nueva tabla llamada audita_personas_borradas cuyos campos
serán: id (serial), id_persona, nombre y apellido, dni y un campo en el cual se indicará si la
persona eliminada era empleado o paciente, la fecha y el usuario que eliminó a la persona.
Además, la función del trigger deberá realizar todas las tareas necesarias para la
eliminación de la persona (eliminar registros de las tablas que referencian a la persona
eliminada).
*/

CREATE TABLE public.audita_personas_borradas
(
    id_aud serial,
    usuario_aud character varying(100),
    fecha_aud time without time zone,
    id_persona integer,
    nombre character varying(100),
    apellido character varying(100),
    dni character varying(8),
    tipo_persona character varying(20)
);

ALTER TABLE IF EXISTS public.audita_personas_borradas
    OWNER to postgres;

CREATE OR REPLACE FUNCTION public.aud_personas_borradas()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
	tipo_persona_aud character varying;
BEGIN
	IF EXISTS (SELECT id_p FROM (SELECT id_paciente as id_p from paciente intersect select id_empleado as id_p from empleado) WHERE id_p = old.id_persona) THEN
		tipo_persona_aud:= 'AMBOS';
		call borrar_empleado_parcial(old.id_persona);
		call borrar_paciente_parcial(old.id_persona);
	ELSIF EXISTS (SELECT id_paciente FROM paciente WHERE id_paciente = old.id_persona) THEN
		tipo_persona_aud:= 'PACIENTE';
		call borrar_paciente_parcial(old.id_persona);
	ELSE
		tipo_persona_aud:= 'EMPLEADO';
		call borrar_empleado_parcial(old.id_persona);
	END IF;
	INSERT INTO public.audita_personas_borradas(id_aud, usuario_aud, fecha_aud, id_persona, nombre, apellido, dni, tipo_persona)
	VALUES (DEFAULT, user, now()::timestamp(0), old.id_persona, old.nombre, old.apellido, old.dni, tipo_persona_aud);
	return old;
END;
$$;

create trigger aud_personas_borradas
before delete on persona
for each row execute procedure aud_personas_borradas();

-- CREAMOS FUNCIONES QUE BORRAN EMPLEADOS Y PERSONAS
CREATE OR REPLACE PROCEDURE public.borrar_empleado_parcial(IN id_empleado_borrar integer)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM diagnostico WHERE id_empleado = id_empleado_borrar;
	DELETE FROM consulta WHERE id_empleado = id_empleado_borrar;
	DELETE FROM internacion WHERE ordena_internacion = id_empleado_borrar;
	DELETE FROM mantenimiento_cama WHERE id_empleado = id_empleado_borrar;
	DELETE FROM mantenimiento_equipo WHERE id_empleado = id_empleado_borrar;
	DELETE FROM estudio_realizado WHERE id_empleado = id_empleado_borrar;
	DELETE FROM tratamiento WHERE prescribe = id_empleado_borrar;
	DELETE FROM compra WHERE id_empleado = id_empleado_borrar;
	DELETE FROM trabajan WHERE id_empleado = id_empleado_borrar;
	DELETE FROM empleado WHERE id_empleado = id_empleado_borrar;
	IF found THEN
		raise notice 'BORRADO DE EMPLEADO EXITOSO'; --es valido poner aqui este raise puesto que es una funcion o no es necesario por el tipo de retorno
	END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE public.borrar_paciente_parcial(IN id_paciente_borrar integer)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM pago WHERE  id_factura in (select id_factura from factura where id_paciente = id_paciente_borrar); 
	DELETE FROM internacion WHERE id_paciente = id_paciente_borrar;
	DELETE FROM estudio_realizado WHERE id_paciente = id_paciente_borrar;
	DELETE FROM tratamiento WHERE id_paciente = id_paciente_borrar;
	DELETE FROM diagnostico WHERE id_paciente = id_paciente_borrar;
	DELETE FROM consulta WHERE id_paciente = id_paciente_borrar;
	DELETE FROM paciente WHERE id_paciente = id_paciente_borrar;
	IF found THEN
		raise notice 'BORRADO DE paciente EXITOSO';
	END IF;
END;
$$;


select * from paciente
where id_paciente = 1043;

select * from persona
where id_persona = 1043;

select * from empleado
where id_empleado = 1043;

start transaction
	DELETE FROM persona WHERE id_persona = 396;
	DELETE FROM persona WHERE id_persona = 1043;
	DELETE FROM persona WHERE id_persona = 108;
	 
	select * from audita_personas_borradas
rollback