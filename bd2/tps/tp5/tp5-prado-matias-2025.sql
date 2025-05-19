CREATE DATABASE tp5
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
--creo el tipo de dato compuesto domicilio
CREATE TYPE public.domicilio AS
(
	calle character varying(50),
	numero smallint,
	ciudad character varying(100)
);

ALTER TYPE public.domicilio
    OWNER TO postgres;
	
--creo los enums para sector y cargo de la tabla empleado
CREATE TYPE public.cargo AS ENUM
    ('administrativo', 'vendedor', 'cajero', 'gerente');

ALTER TYPE public.cargo
    OWNER TO postgres;
	
CREATE TYPE public.sector AS ENUM
    ('ventas', 'compras', 'gerencia', 'deposito');

ALTER TYPE public.sector
    OWNER TO postgres;
	
	
--creamos tabla y aplicamos herencia

CREATE TABLE public.persona
(
    id_persona serial,
    nombre character varying(100),
    dni character varying(8),
    domicilio domicilio,
    mail character varying(100)[],
	primary key(id_persona)
);

ALTER TABLE IF EXISTS public.persona
    OWNER to postgres;

CREATE TABLE public.empleado
(
	sueldo numeric(10, 2),
	legajo character varying(10),
    sector sector,
    cargo cargo
)
    INHERITS (public.persona);

ALTER TABLE IF EXISTS public.empleado
    ADD PRIMARY KEY (id_persona);

ALTER TABLE IF EXISTS public.empleado
    OWNER to postgres;



CREATE TABLE public.cliente
(
    cuenta_corriente character varying(12)
)
    INHERITS (public.persona);
	
ALTER TABLE IF EXISTS public.cliente
    ADD PRIMARY KEY (id_persona);

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;

CREATE TABLE public.pedido
(
    fecha date,
    total numeric(10, 2),
    id_empleado integer,
    id_cliente integer,
    PRIMARY KEY (fecha, id_cliente),
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
        REFERENCES public.cliente (id_persona) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
        REFERENCES public.empleado (id_persona) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.pedido
    OWNER to postgres;
	
-- C)	
START TRANSACTION;
INSERT INTO public.empleado(id_persona, nombre, dni, domicilio, mail, sector, cargo, legajo, sueldo)
VALUES (DEFAULT, 'VILCARROMERO, ERIK', '17130935', row('AV SANTA ROSA', '1177','S.M.TUC' ), ARRAY['vilcarro@gmail.com', 'vilco@live.com'], 'ventas', 'cajero','1232', 550000);
commit;

START TRANSACTION;
INSERT INTO public.empleado(id_persona, nombre, dni, domicilio, mail, sector, cargo, legajo, sueldo)
VALUES ((SELECT MAX(id_persona)+1 from empleado), 'MUNIZ, SILVA', '27418519', row('AV.AREQUIPA', '2288','SALTA' ), ARRAY['muniz@gmail.com', 'silvi@gmail.com'], 'gerencia', 'gerente','1002', 692000);

SELECT * FROM empleado
commit;

START TRANSACTION;
INSERT INTO public.cliente(id_persona, nombre, dni, domicilio, mail, cuenta_corriente)
VALUES (DEFAULT, 'JARUFE, ERNESTO', '31569934', ('LAS BEGONIAS', '451', 'LA PLATA'), ARRAY['jarus@gmail.com'], 'F1515');
SELECT * FROM cliente
commit;


--d)
SELECT * FROM empleado;
SELECT * FROM cliente;
SELECT * FROM persona;
/*
Esto se debe a que el tipo de dato serial trabaja siempre con el DEFAULT.
Las anomalias vistas (la posibilidad de repetir id dentro de la tabla persona) es por cuestiones de la herencia
*/



START TRANSACTION;
INSERT INTO public.cliente(id_persona, nombre, dni, domicilio, mail, cuenta_corriente)
VALUES (DEFAULT, 'HUAPAYA, CLAUDIA', '23185175', ('COLOMBIA', '395', 'SALTA'), ARRAY['huap@gmail.com', 'laud@gmail.com'], 'G1254');
SELECT * FROM cliente
commit;

START TRANSACTION;
INSERT INTO public.empleado(id_persona, nombre, dni, domicilio, mail, sector, cargo, legajo, sueldo)
VALUES (DEFAULT, 'VASQUEZ, JUAN', '44125608', row('AV REPUBLICA', '3755', 'SALTA' ), ARRAY['VASQUEZ@gmail.com', 'JUAN@gmail.com'], 'deposito', 'administrativo','1123', 423000);
SELECT * FROM empleado
commit;

--e)
START TRANSACTION;
delete from empleado
WHERE dni = '27418519'
commit;

START TRANSACTION;
INSERT INTO public.cliente(id_persona, nombre, dni, domicilio, cuenta_corriente)
VALUES (4, 'RAMES, MAYRA', '12113059', ('J.P FERNANDINI', '1140', 'LA PLATA'), ARRAY['huap@gmail.com', 'laud@gmail.com'], 'G1254');
SELECT * FROM cliente
commit;	