/*
1er PARCIAL
*/

/*
a) Crear las tablas y definir el tipo de dato de cada uno de los campos.
1. Se desea agregar al sistema a los familiares de los empleados. Los datos requeridos son id_familiar,
nombre, apellido, id_empleado, fecha_nacimiento, dni y parentesco.
2. Se requiere agregar la cuidad y la provincia de cada paciente.
*/

-- 1)
CREATE TABLE public.familiar
(
    id_familiar integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    id_empleado integer NOT NULL,
    fecha_nacimiento date NOT NULL,
    dni character varying(8) NOT NULL,
    parentesco character varying(50) NOT NULL,
    PRIMARY KEY (id_familiar),
    CONSTRAINT fk_familiar_empleado FOREIGN KEY (id_empleado)
        REFERENCES public.empleado (id_empleado) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.familiar
    OWNER to postgres;

--2
--creamos la tabla provincia
CREATE TABLE public.provincia
(
    id_provincia integer NOT NULL,
    provincia character varying(100) NOT NULL,
    PRIMARY KEY (id_provincia)
);

ALTER TABLE IF EXISTS public.provincia
    OWNER to postgres;

--creamos la tabla ciudad
CREATE TABLE public.ciudad
(
    id_ciudad integer NOT NULL,
    ciudad character varying(100) NOT NULL,
    id_provincia integer NOT NULL,
    PRIMARY KEY (id_ciudad),
    CONSTRAINT fk_provincia FOREIGN KEY (id_provincia)
        REFERENCES public.provincia (id_provincia) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.ciudad
    OWNER to postgres;

--modificamos la tabla paciente para agregar el campo y tener normalizada la bd
ALTER TABLE IF EXISTS public.paciente
    ADD COLUMN id_ciudad integer;
ALTER TABLE IF EXISTS public.paciente
    ADD CONSTRAINT fk_ciudad FOREIGN KEY (id_ciudad)
    REFERENCES public.ciudad (id_ciudad) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET DEFAULT
    NOT VALID;


/*
b) Que índice/s propone para las siguientes consultas
*/
--a
EXPLAIN ANALYZE select * from factura where fecha > '2020-01-01'

/*
propongo un indice secundario para el campo fecha teniendo asi ordenadas las tuplas para acceder rapidamente a disintas fechas
*/

CREATE INDEX idx_fecha ON factura(pagada, fecha) -- no  

--b
explain analyze select sigla, nombre from obra_social where localidad = 'localidad' and provincia = 'provincia'

/*
propongo un indice por localidad, puesto que para cada provincia puede haber un numero importante de localidades respecto al numero de provincias por lo que solamente se necesita un indice para localidades
*/

CREATE INDEX idx_localidad ON obra_social(localidad)

--c
EXPLAIN ANALYZE select m.nombre, m.presentacion from medicamento m
inner join compra c on c.id_medicamento =m.id_medicamento
inner join proveedor p on p.id_proveedor =c.id_proveedor
where p.proveedor = 'proveedor'
/*
3. para esta consulta propongo la creación de un índice para el campo "id_proveedor" de la tabla compra, puesto que asi logro agrupar todos los medicamentos de determinado proveedor rapidamente
*/
CREATE INDEX idx_id_proveedor_compra ON compra(id_proveedor)


/*
EJERCICIO N° 2: Usuarios y Permisos
*/

--a) Cree el grupo SegParcial
CREATE ROLE "segparcial" WITH
	NOLOGIN
	NOSUPERUSER
	CREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;
--b) Cree el usuario Apellido_inicial de cada alumno, por ejemplo, si su nombre es Lionel Messi el usuario debe ser “messil”. Agregue el usuario al grupo
CREATE ROLE pradom WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '1234';

GRANT USAGE ON SCHEMA public TO segparcial

/*
c) Asigne los permisos mínimos necesarios y realice las siguientes tareas (la consulta SQL que lo resuelve) con el
usuario Apellido_inicial. (tenga en cuenta que hay 20 usuarios más que deben poder realizar las mismas
tareas).
*/

--1. Crear un esquema llamado jubilaciones
CREATE SCHEMA jubilaciones
    AUTHORIZATION pradom;
--2. En el esquema jubilaciones debe crear una tabla llamada empleado_jubilado con los campos, id_empleado, nombre, apellido, dni, edad y antigüedad.
CREATE TABLE jubilaciones.empleado_jubilado
(
    id_empleado integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    dni character varying(8) NOT NULL,
    edad smallint NOT NULL,
    antiguedad smallint NOT NULL,
    PRIMARY KEY (id_empleado, nombre)
);

ALTER TABLE IF EXISTS jubilaciones.empleado_jubilado
    OWNER to pradom;

--3. Inserte en la tabla empleado_jubilado todos los empleados que tengan más de 70 años de edad y 30 años de antigüedad.
INSERT INTO jubilaciones.empleado_jubilado (id_empleado, nombre, apellido, dni, edad, antiguedad)
SELECT
	e.id_empleado,
    p.nombre,
    p.apellido,
    p.dni,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento)) AS edad,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.fecha_ingreso)) AS antiguedad
FROM
    empleado AS e
INNER JOIN
    persona AS p ON e.id_empleado = p.id_persona
WHERE
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento)) >= 70
    AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.fecha_ingreso)) >= 30;

SELECT * FROM jubilaciones.empleado_jubilado
ORDER BY antiguedad DESC

--4. Elimine las compras realizadas entre 01/03/2020 y 15/03/2022, de los medicamentos cuya clasificación es ‘ANTIVIRAL’.
START TRANSACTION
DELETE FROM compra c
WHERE id_medicamento IN (SELECT id_medicamento FROM medicamento INNER JOIN clasificacion USING(id_clasificacion) WHERE clasificacion = 'ANTIVIRAL') AND fecha >= '2020-03-01' AND fecha <= '2022-03-15'
commit
 

