/*
EJERCICIO N° 1: Índices y Tipo de datos
a) Crear las tablas y definir el tipo de dato de cada uno de los campos.
1. Se desea agregar al sistema a los familiares de los empleados. Los datos requeridos son id_familiar,
nombre, apellido, id_empleado, fecha_nacimiento, dni y parentesco.
2. Se requiere agregar la cuidad y la provincia de cada paciente.v
*/

--1

CREATE TABLE public.familiar
(
    id_familiar serial NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    id_empleado integer,
    fecha_nacimiento date NOT NULL,
    dni character varying(8) NOT NULL,
    PRIMARY KEY (id_familiar),
    CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
        REFERENCES public.empleado (id_empleado) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
        NOT VALID
);

ALTER TABLE IF EXISTS public.familiar
    OWNER to postgres;
	
--2

CREATE TABLE public.provincia
(
    id_provincia serial,
    provincia character varying(50) NOT NULL,
    PRIMARY KEY (id_provincia)
);

ALTER TABLE IF EXISTS public.provincia
    OWNER to postgres;

CREATE TABLE public.ciudad
(
    id_ciudad serial,
    ciudad character varying(50) NOT NULL,
    id_provincia integer,
    PRIMARY KEY (id_ciudad),
    CONSTRAINT fk_provincia FOREIGN KEY (id_provincia)
        REFERENCES public.provincia (id_provincia) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.ciudad
    OWNER to postgres;

/*
b) Que índice/s propone para las siguientes consultas
1. select * from factura where pagada = 'N' and fecha > '2020-01-01'
2. select sigla, nombre from obra_social where localidad = 'localidad' and provincia = 'provincia'
3. select m.nombre, m.presentacion from medicamento m
 inner join compra c on c.id_medicamento =m.id_medicamento
 inner join proveedor p on p.id_proveedor =c.id_proveedor
 where p.proveedor = 'proveedor	'
 
 1. Propongo un indice para el campo fecha, puesto que de esta manera podrá encontrar rápida mente el bloque de tuplas correspondiente a las facturas no pagadas de la fecha solicitada
*/
CREATE INDEX idx_fecha_factura ON factura(fecha)
/*
2. El índice que considero adecuado seria uno para el campo "localidad", puesto que entre de las provincias, que nunca serán un numero exagerado, puede haber muchas localidades por ende para mejorar el rendimiento filtrar estas primero a través de un índice lo considero correcto.
*/
CREATE INDEX idx_localidad_localidad ON localidad(localidad)

/*
3. para esta consulta propongo la creación de un índice para el campo "id_proveedor" de la tabla compra, puesto que asi logro agrupar todos los medicamentos de determinado proveedor rapidamente
*/
CREATE INDEX idx_id_proveedor_compra ON compra(id_proveedor)

/*
EJERCICIO 2
*/
--creamos el grupo SegParcial
CREATE ROLE "SegParcial" WITH
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;

--creamos el usuario
CREATE ROLE pradom WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT "SegParcial" TO pradom WITH ADMIN OPTION; -- agregamos al usuario con permisos de administrador
GRANT USAGE ON SCHEMA public TO "jubilaciones";
GRANT USAGE ON SCHEMA public TO "SegParcial";-- le damos permiso al grupo para acceder a los schemas, en este caso al public

--creamos la tabla en el esquema
CREATE SCHEMA jubilaciones
    AUTHORIZATION "SegParcial";

CREATE TABLE jubilaciones.jubilaciones
(
    id_empleado integer,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    dni character varying(8) NOT NULL,
    edad integer NOT NULL,
    antiguedad integer NOT NULL,
    PRIMARY KEY (id_empleado)
);

ALTER TABLE IF EXISTS jubilaciones.jubilaciones
    OWNER to "SegParcial";
	
INSERT INTO jubilaciones.jubilaciones(
	id_empleado, nombre, apellido, dni, edad, antiguedad)
	VALUES (, ?, ?, ?, ?, ?);

-- damos permiso para poder eliminar los registros solicitados
GRANT SELECT, DELETE ON TABLE public.clasificacion TO "SegParcial" WITH GRANT OPTION;


DELETE FROM compra
INNER JOIN medicamento USING (id_medicamento)
INNER JOIN clasificación USING(id_clasificacion)
WHERE clasificación ='ANTIVIRAL' AND fecha BETWEEN '2020-03-01' AND '2022-03-15' 


-- EJERCICIO 3

START TRANSACTION;

--a)
CREATE SCHEMA facturacion
    AUTHORIZATION postgres;
SAVEPOINT creacion_esquema

CREATE TABLE facturacion.paciente
(
    LIKE public.paciente
        INCLUDING DEFAULTS
        INCLUDING CONSTRAINTS
        INCLUDING INDEXES
        INCLUDING STORAGE
        INCLUDING COMMENTS

);

ALTER TABLE IF EXISTS facturacion.paciente
OWNER to postgres;


SAVEPOINT tabla_paciente

COMMIT
ROLLBACK;




