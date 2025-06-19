/*
Se puede hacer auditorias mediante la aplicacion y por triggers como normalmente
En caso de haber hecho mal un trigger, puedo ante cualquier proceso me va a quedar registrado
*/

-- Ejercicio a)
-- c) 3 acciones llaman a la misma funcion
-- d) TIPO PARCIAL

CREATE TABLE public.audita_factura
(
    id serial NOT NULL,
    usuario_aud character varying(50),
    fecha_aud date NOT NULL,
	operacion character varying(20),
    id_factura bigint NOT NULL,
    id_paciente integer NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    monto numeric(10, 2) NOT NULL,
    pagada character(10) NOT NULL,
    saldo numeric(10, 2) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.audita_factura
    OWNER to postgres;

CREATE OR REPLACE FUNCTION aud_factura() RETURNS TRIGGER AS $$
BEGIN
	IF(tg_op = 'INSERT') 
	THEN
		INSERT INTO audita_factura
			VALUES(default,
					user,
					CURRENT_DATE,
					tg_op,
					new.id_factura,
					new.id_paciente,
					new.fecha,
					new.hora,
					new.monto,
					new.pagada,
					new.saldo);
		RETURN NEW;
	ELSIF(tg_op = 'DELETE')
	THEN
		INSERT INTO audita_factura
			VALUES(default,
					user,
					CURRENT_DATE,
					tg_op,
					old.id_factura,
					old.id_paciente,
					old.fecha,
					old.hora,
					old.monto,
					old.pagada,
					old.saldo);
		RETURN OLD;
	ELSIF(tg_op = 'UPDATE')
	THEN
		INSERT INTO audita_factura
			VALUES(default,
					user,
					CURRENT_DATE,
					'antes',
					old.id_factura,
					old.id_paciente,
					old.fecha,
					old.hora,
					old.monto,
					old.pagada,
					old.saldo);
		INSERT INTO audita_factura
			VALUES(default,
					user,
					CURRENT_DATE,
					'despues',
					new.id_factura,
					new.id_paciente,
					new.fecha,
					new.hora,
					new.monto,
					new.pagada,
					new.saldo);
		RETURN NEW;
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM pago WHERE id_factura =  1064159;
SELECT * FROM factura ORDER BY id_factura DESC;
SELECT * FROM audita_factura ORDER BY id DESC;

BEGIN;
rollback;

INSERT INTO factura VALUES((SELECT MAX(id_factura) + 1 FROM factura), 510, CURRENT_DATE, CURRENT_TIME, 200000,'N', 500);

DELETE FROM factura WHERE id_factura = 1064159;

UPDATE factura
	SET monto = 120
	WHERE id_factura = 1064161;

CREATE TRIGGER audita_fac1 BEFORE INSERT OR UPDATE OR DELETE ON factura
FOR EACH ROW EXECUTE PROCEDURE aud_factura();

-- Ejercicio b)

CREATE TABLE public.audita_empleado_sueldo
(
    id serial NOT NULL,
    usuario character varying(20) NOT NULL,
    fecha date NOT NULL,
    id_empleado integer NOT NULL,
    dni character varying(8) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    sueldo_viejo numeric(9, 2) NOT NULL,
    sueldo_nuevo numeric(9, 2) NOT NULL,
    porcentaje numeric(5, 2) NOT NULL,
    estado character varying(20) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.audita_empleado_sueldo
    OWNER to postgres;


CREATE OR REPLACE FUNCTION aud_empleado_salario() RETURNS TRIGGER AS $$
BEGIN
IF(new.sueldo > old.sueldo)
THEN
	INSERT INTO audita_empleado_sueldo
		VALUES(default,
				user,
				CURRENT_DATE,
				new.id_empleado,
				(SELECT dni FROM persona WHERE id_persona = new.id_empleado),
				(SELECT nombre FROM persona WHERE id_persona = new.id_empleado),
				(SELECT apellido FROM persona WHERE id_persona = new.id_empleado),
				old.sueldo,
				new.sueldo,
				((new.sueldo*100)/old.sueldo - 100),
				'aumento');
ELSE
	INSERT INTO audita_empleado_sueldo
		VALUES(default,
				user,
				CURRENT_DATE,
				new.id_empleado,
				(SELECT dni FROM persona WHERE id_persona = new.id_empleado),
				(SELECT nombre FROM persona WHERE id_persona = new.id_empleado),
				(SELECT apellido FROM persona WHERE id_persona = new.id_empleado),
				old.sueldo,
				new.sueldo,
				(100 - (new.sueldo*100)/old.sueldo),
				'descuento');
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER aud_empleado_sueldo AFTER UPDATE OF sueldo ON empleado
FOR EACH ROW EXECUTE PROCEDURE aud_empleado_salario();

SELECT * FROM empleado WHERE id_empleado = 2;

UPDATE empleado
	SET sueldo = 100
	WHERE id_empleado = 2;

SELECT * FROM audita_empleado_sueldo;
-- id_empleado 2;
rollback;
begin;

-- Ejercicio c)

CREATE TABLE public.audita_tablas_sistema
(
    id serial NOT NULL,
    usuario character varying(50) NOT NULL,
    fecha_aud date NOT NULL,
    id_paciente integer NOT NULL,
    fecha date NOT NULL,
    nombre_tabla character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.audita_tablas_sistema
    OWNER to postgres;

CREATE TABLE public.estudio_borrado AS SELECT * FROM public.estudio_realizado WITH NO DATA; 
CREATE TABLE public.tratamiento_borrado AS SELECT * FROM public.tratamiento WITH NO DATA; 
CREATE TABLE public.consulta_borrado AS SELECT * FROM public.consulta WITH NO DATA; 

CREATE OR REPLACE FUNCTION aud_tablas_sistema() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO audita_tablas_sistema
		VALUES(default,
				user,
				CURRENT_DATE,
				old.id_paciente,
				old.fecha,
				tg_table_name);
	IF(tg_table_name = 'tratamiento') 
	THEN
		INSERT INTO tratamiento_borrado
			SELECT * FROM tratamiento WHERE id_paciente = old.id_paciente AND id_medicacion = old.id_medicacion AND fecha_indicacion = old.fecha_indicacion;
	ELSIF (tg_table_name = 'consulta')
	THEN
		INSERT INTO consulta_borrado
			SELECT * FROM consulta WHERE id_paciente = old.paciente AND id_empleado = old.id_empleado AND fecha = old.fecha;
	ELSIF (tg_table_name = 'estudio_realizado')
	THEN
		INSERT INTO estudio_borrado
			SELECT * FROM estudio_realizado WHERE id_paciente = old.id_paciente AND id_estudio = old.id_estudio AND fecha = old.fecha;
	END IF;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audita_tablas_sistema BEFORE DELETE ON estudio_realizado
FOR EACH ROW EXECUTE PROCEDURE aud_tablas_sistema();

CREATE TRIGGER audita_tablas_sistema BEFORE DELETE ON tratamiento
FOR EACH ROW EXECUTE PROCEDURE aud_tablas_sistema();

CREATE TRIGGER audita_tablas_sistema BEFORE DELETE ON consulta
FOR EACH ROW EXECUTE PROCEDURE aud_tablas_sistema();

-- Ejercicio d)

CREATE TABLE public.audita_personas_borradas
(
    id serial NOT NULL,
    id_persona integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    dni character varying(8) NOT NULL,
    tipo_persona character varying(50) NOT NULL,
    fecha date NOT NULL,
    usuario character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.audita_personas_borradas
    OWNER to postgres;

CREATE OR REPLACE FUNCTION aud_persona() RETURNS TRIGGER AS $$
DECLARE
	v_tipo_persona text;
BEGIN
	IF EXISTS(SELECT id_empleado FROM empleado WHERE id_empleado = old.id_persona)
	THEN
		v_tipo_persona:= 'empleado';
		DELETE FROM diagnostico
			WHERE id_empleado = old.id_persona;
		DELETE FROM consulta
			WHERE id_empleado = old.id_persona;
		DELETE FROM internacion
			WHERE ordena_internacion = old.id_persona;
		DELETE FROM mantenimiento_cama
			WHERE id_empleado = old.id_persona;
		DELETE FROM mantenimiento_equipo
			WHERE id_empleado = old.id_persona;
		DELETE FROM estudio_realizado
			WHERE id_empleado = old.id_persona;
		DELETE FROM tratamiento
			WHERE prescribe = old.id_persona;
		DELETE FROM compra
			WHERE id_empleado = old.id_persona;
		DELETE FROM empleado
			WHERE id_empleado = old.id_persona;
	ELSE
		v_tipo_persona:= 'paciente';
		DELETE FROM diagnostico
			WHERE id_paciente = old.id_persona;
		DELETE FROM consulta
			WHERE id_paciente = old.id_persona;
		DELETE FROM internacion
			WHERE id_paciente = old.id_persona;
		DELETE FROM estudio_realizado
			WHERE id_paciente = old.id_persona;
		DELETE FROM tratamiento
			WHERE id_paciente = old.id_persona;
		DELETE FROM pago
			WHERE id_factura = (SELECT id_factura FROM factura WHERE id_paciente = old.id_persona);
		DELETE FROM factura
			WHERE id_paciente = old.id_persona;
		DELETE FROM paciente
			WHERE id_paciente = old.id_persona;	
	END IF;
	INSERT INTO audita_personas_borradas
		VALUES(default,
				old.id_persona,
				(SELECT nombre FROM persona WHERE id_persona = old.id_persona),
				(SELECT apellido FROM persona WHERE id_persona = old.id_persona),
				(SELECT dni FROM persona WHERE id_persona = old.id_persona),
				v_tipo_persona,
				CURRENT_DATE,
				USER);
RETURN OLD;	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audita_personas_borradas BEFORE DELETE ON persona
FOR EACH ROW EXECUTE PROCEDURE aud_persona();

SELECT * FROM audita_personas_borradas;
BEGIN;
rollback;

-- Ejercicio e

CREATE TABLE public.audita_pago
(
    id serial NOT NULL,
	usuario_aud character varying(50),
    fecha_aud date NOT NULL,
	operacion character varying(20),
    id_factura bigint NOT NULL,
    fecha date NOT NULL,
    monto numeric(10, 2) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.audita_pago
    OWNER to postgres;

CREATE OR REPLACE FUNCTION aud_pago() RETURNS TRIGGER AS $$
BEGIN
	IF(tg_op = 'INSERT') 
	THEN
		INSERT INTO audita_pago
			VALUES(default,
					user,
					CURRENT_DATE,
					tg_op,
					new.id_factura,
					new.fecha,
					new.monto);
		RETURN NEW;
	ELSIF(tg_op = 'DELETE')
	THEN
		INSERT INTO audita_pago
			VALUES(default,
					user,
					CURRENT_DATE,
					tg_op,
					old.id_factura,
					old.fecha,
					old.monto);
		RETURN OLD;
	ELSIF(tg_op = 'UPDATE')
	THEN
		INSERT INTO audita_pago
			VALUES(default,
					user,
					CURRENT_DATE,
					'antes',
					old.id_factura,
					old.fecha,
					old.monto);
		INSERT INTO audita_factura
			VALUES(default,
					user,
					CURRENT_DATE,
					'despues',
					new.id_factura,
					new.fecha,
					new.monto);
		RETURN NEW;
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audita_pago AFTER INSERT OR UPDATE OR DELETE ON factura
FOR EACH ROW EXECUTE PROCEDURE aud_pago();


