select * from consultorio

SELECT * FROM consultorio ORDER BY interno --ANTES DEL UPDATE ESTA TODO CORRECTO

UPDATE consultorio SET interno = 100 -- luego del update el interno modificado se pone primero "desordenando el orden ascendente de la sentencia ORDER BY"
WHERE nombre = 'GINECOLOGIA'


select * from tratamiento

UPDATE tratamiento SET dosis = dosis + 2 -- no se puede sumar al tipo charvarying un integer
WHERE id_paciente = 71387

--cambiamos el tipo de dato de la columna interno en consultorio
ALTER TABLE public.consultorio
    ALTER COLUMN interno TYPE integer USING interno::integer;
	
--cambiamos el tipo de dato de la columna dosis en tratamiento
ALTER TABLE public.tratamiento
    ALTER COLUMN dosis TYPE smallint USING dosis::smallint;

--EJERCICIO 2
/*
a) ¿En la tabla consulta es mejor tener un índice por fecha y resultado o por resultado y
fecha? Justifique.

	es mejor tener un indice por fecha y resultado puesto que mayoritariamente se suelen buscar consultas recientes para acceder al resultado, por ende tener un primer filtrado por fecha generaria un menor numero de filas para buscar determinado resultado
*/

CREATE INDEX idx_consulta_fecha_resultado ON consulta(fecha,resultado)

/*
b) Si se necesita consultar, por un lado, las facturas emitidas en un determinado día, y, por
otro lado, las facturas que aún no fueron pagadas. ¿Crearía índices? Especifique.

para determinar las facturas emitidas detemrinado dia si lo haria, pues asi lograria agrupar facturas segun su fecha de emision y asi tener un acceso instantaneo al conjunto de facturas emitidas

para el caso de si la factura esta pagada o no pues no convendria pues seria añadir un indice innecesario a un campo que solamente toma dos valores posibles como en este caso "S" y "N"
*/

CREATE INDEX idx_factura_fecha_emision ON factura(fecha)
drop INDEX idx_factura_fecha_emision
select * from factura

/*
c) ¿En la tabla habitación es mejor tener un índice por piso y número o por número y piso?

dudo de la respuesta:
para este caso considero que el mejor indice posible a crear seria por piso y numero. Aunque a pesar de que esto depende mucho de como esta estructurizado el hospital, si las habitaciones se repiten en nombre pero en distinto pisos o si se tiene mas pisos que habitaciones por cada uno, entre otros factores. Para este caso considero que la relacion habitaciones/piso grande y ademas que las habitaciones se repiten con su nombre por lo que implementaria un indice UNIQUE compuesto de piso y numero

mejor respuesta despues de ver la distribucion de los numeros y piso de las habitaciones
	considero para este caso que seria mejor un indice de la forma numero, piso, puesto que en esta bd del hospital en cuestion maneja con numero distintivos de habitacion para cada piso, donde cada numero de habitacion comienza con el numero de piso correspondiente, por lo que crear un indice donde se ordenen primeramente los numeros de la habitaciones ayudara a encontrar rapidamente a que piso corresponde dicha habitacion. Aunque la cantidad de tuplas es minima (90) la implementacion del indice puede preveer una posible escalabilidad del hospital y asi manter eficiente la cosulta de habitaciones
*/

CREATE INDEX idx_habitacion_numero_piso ON habitacion(numero,piso)
select * from habitacion

/*
d) ¿Me conviene tener un índice en la tabla tipo_estudio?
a menos que existan una cantidad importante de tipo de estudios o la busqueda por el tipo de estudio sea muy recurrente considero que no es conveniente tener un indice en esta tabla debido a la poca cantidad de tuplas.
*/

/*
e) Si necesito ver todas las consultas médicas de un determinado paciente, ¿cómo crearía el
índice?
Para ver las consultas de un paciente, se busca su información en base a su nombre y
apellido o a su DNI, y como obtener esa información implica hacer un JOIN con paciente y
luego persona, el índice debería estar en la tabla persona, ya sea un índice compuesto por
apellido y nombre o un índice por DNI. Indistintamente de cómo se arme la consulta para
ver la información, el motor realizará primero el filtro en la tabla persona y luego hará los
correspondientes JOIN.
*/
CREATE INDEX idx_persona_consultas_medicas_determinado_paciente ON persona(dni)
drop INDEX idx_consulta_id_paciente 

/*
f) Si necesito ver las facturas cuyo monto sea superior a 100.000, ¿cómo crearía el índice?
CREATE INDEX idx_consulta_id_paciente ON consulta(id_paciente)
teniendo en cuenta la magnitud e importancia y ademas la recurrenccia de la tabla factura entonces hay dos posibilidades de crear un indice para realizar la consulta en cuestion
*/
CREATE INDEX idx_secundario_factura_monto ON factura(monto)
CREATE INDEX idx_parcial_factura_monto ON factura(monto) WHERE monto > 100000

/*
g) Si necesito ver todas las internaciones que realizaron los psiquiatras, ¿cómo crearía el
índice?
teniendo en cuenta que para realizar determinada consulta lo mas probable es que se realice un JOIN de la tabla internacion y empleado filtrando por especialidad, tener un indice por ordena_internacion en la tabla internacion logrando asi agrupar todas las internaciones realizadas por determinados empleados entonces a la hora de filtrar por especialidad reducimos el tiempo de union y el filtrado final por la especialidad se hace a un menor costo

LO DE ABAJO ES LO DE LA SOLUCION
En este caso no haría un índice, porque al igual que en el apartado e, el índice debería
estar en la tabla especialidad, pero como en dicha tabla no hay muchos registros, no es
necesario un índice. Nuevamente, el motor primero hará el filtro en la tabla especialidad y
luego los respectivos JOIN, indistintamente de cómo esté armada la consulta SQL.
*/
CREATE INDEX idx_internacion_ordena_internacion ON internacion(ordena_internacion)

/*EJERCICIO 3*/

/*
a) Obtenga el tiempo de planeamiento y ejecución de la consulta SQL que permita encontrar
todas las facturas del primer trimestre del 2021.
*/
EXPLAIN ANALYZE SELECT * FROM factura
WHERE fecha >= '2021-01-01' AND fecha <= '2021-03-31'
ORDER BY fecha; --sin idx Execution Time: 63.908 ms

/*
b) Cree un índice por fecha en la tabla factura.
*/
CREATE INDEX idx_factura_fecha_emision ON factura(fecha)
drop INDEX idx_factura_fecha_emision 

/*
c) Realice nuevamente el apartado a para ver que tanto mejoró el tiempo de ejecución.
Exprese el resultado de mejora en porcentaje.

*/

EXPLAIN ANALYZE SELECT * FROM factura
WHERE fecha >= '2021-01-01' AND fecha <= '2021-03-31'
ORDER BY fecha; --con idx Execution Time: 35.581 ms

-- mejora porcentual 55.77%

/*
d) Muestre el tamaño de la tabla factura y el tamaño de los índices.
*/
select pg_size_pretty(pg_table_size('factura')) as "tamaño tabla", pg_size_pretty(pg_indexes_size( 'factura')) as "tamaño indices" 