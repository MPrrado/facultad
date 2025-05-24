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
VALUES (4, 'RAMES, MAYRA', '12113059', row('J.P FERNANDINI', '1140', 'LA PLATA'),'C3321');
SELECT * FROM cliente
commit;
rollback;

START TRANSACTION;
INSERT INTO public.cliente(id_persona, nombre, dni, domicilio, mail)
VALUES (4, 'ABON, ALFREDO ', '29085527', ('AV BOLIVIA', '1157', 'S.M.TUC'), ARRAY['abon@gmail.com', 'abon@live.com']);
SELECT * FROM persona
commit;

/*
solo se pudo hacer el insert de RAMES MAYRA, el otro no pues se repetian los id que son pk
*/

--g)

--propongo herencia y particiones en la tabla pedidos a traves de creacion de tablas que contengan los pedidos realizados en determinado año
CREATE TABLE public.pedido_2021
(
	check (fecha >= '2021-01-01' and fecha <= '2021-12-31')
)
    INHERITS (public.pedido);

ALTER TABLE IF EXISTS public.pedido_2021
    OWNER to postgres;
ALTER TABLE IF EXISTS public.pedido_2021
    ADD PRIMARY KEY (fecha, id_cliente);


CREATE TABLE public.pedido_2022
(
	check (fecha >= '2022-01-01' and fecha <= '2022-12-31')
)
    INHERITS (public.pedido);

ALTER TABLE IF EXISTS public.pedido_2022
    OWNER to postgres;
ALTER TABLE IF EXISTS public.pedido_2022
    ADD PRIMARY KEY (fecha, id_cliente);
	
CREATE TABLE public.pedido_2023
(
	check (fecha >= '2023-01-01' and fecha <= '2023-12-31')
)
    INHERITS (public.pedido);

ALTER TABLE IF EXISTS public.pedido_2023
    OWNER to postgres;
ALTER TABLE IF EXISTS public.pedido_2023
    ADD PRIMARY KEY (fecha, id_cliente);
	
	
	
--EJERCICIO 2

--a)
CREATE TYPE public.obra_social_paciente AS
(
	id_paciente integer,
	nombre_paciente character varying(100),
	apellido_paciente character varying(100),
	sigla_obra_social character varying(15),
	nombre_obra_social character varying(100)
);

ALTER TYPE public.obra_social_paciente
    OWNER TO postgres;

--b)
CREATE TYPE public.informacion_empleado AS
(
	id_empleado integer,
	nombre_empleado character varying(100),
	apellido_empleado character varying(100),
	sueldo numeric(9, 2),
	cargo character varying(50)
);

ALTER TYPE public.informacion_empleado
    OWNER TO postgres;
	
--c)

CREATE TYPE public.ingreso_empleado AS
(
	id_empleado integer,
	nombre_empleado character varying(100),
	apellido_empleado character varying(100),
	fecha_ingreso date,
	especialidad character varying(50)
);

ALTER TYPE public.ingreso_empleado
    OWNER TO postgres;
	
--d)

CREATE TYPE public.stock_medicamento AS
(
	id_medicamento integer,
	nombre character varying(50),
	stock integer,
	clasificacion character varying(75),
	laboratorio character varying(100)
);

ALTER TYPE public.stock_medicamento
    OWNER TO postgres;
	
--e)

CREATE TYPE public.informacion_venta_medicamento AS
(
	id_medicamento integer,
	nombre_medicamento character varying(50),
	clasificacion character varying(75),
	laboratorio character varying(50),
	proveedor character varying(50),
	precio numeric(8, 2)
);

ALTER TYPE public.informacion_venta_medicamento
    OWNER TO postgres;
	
	
--f)
CREATE TYPE public.consulta_realizada AS
(
	nombre_paciente character varying(100),
	apellido_paciente character varying(100),
	nombre_medico character varying(100),
	apellido_medico character varying(100),
	fecha_consulta date,
	consultorio character varying(50)
);

ALTER TYPE public.consulta_realizada
    OWNER TO postgres;

--g)

CREATE TYPE public.costo_estudio AS
(
	nombre_paciente character varying(100),
	apellido_paciente character varying(100),
	nombre_estudio character varying(100),
	precio numeric(10, 2),
	fecha date
);

ALTER TYPE public.costo_estudio
    OWNER TO postgres;

--h)
CREATE TYPE public.costo_internacion AS
(
	nombre_paciente character varying(100),
	apellido_paciente character varying(100),
	nombre_medico character varying(100),
	apellido_mediaco character varying(100),
	precio numeric(10, 2),
	fecha_alta date
);

ALTER TYPE public.costo_internacion
    OWNER TO postgres;
	
--i)
CREATE TYPE public.factura_paciente AS
(
	id_factura integer,
	monto_factura numeric(10, 2),
	nombre_paciente character varying(100),
	apellido_paciente character varying(100)
);

ALTER TYPE public.factura_paciente
    OWNER TO postgres;
	
--j)
CREATE TYPE public.pagos_paciente AS
(
	nombre_paciente character varying(100),
	apellid_paciente character varying(100),
	fecha date,
	monto numeric(10, 2)
);

ALTER TYPE public.pagos_paciente
    OWNER TO postgres;

--k)

CREATE TYPE public.equipo_raparacion AS
(
	nombre_empleado character varying(100),
	apellido_empleado character varying(100),
	nombre_equipo character varying(100),
	marca character varying(50),
	fecha_ingreso date,
	estado character varying(25)
);

ALTER TYPE public.equipo_raparacion
    OWNER TO postgres;