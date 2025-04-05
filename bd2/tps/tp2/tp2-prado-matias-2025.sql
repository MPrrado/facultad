	/*
	TP 2 
	*/
	/*1 a)*/
	SELECT * FROM consultorio ORDER BY interno

	/* b) */
	UPDATE consultorio SET interno = 100
	WHERE nombre = 'GINECOLOGIA' -- SE DESORDENA Y CAMBIA COMOSE MUESTRA LA INFORMACION

	/* c) */	
	UPDATE tratamiento set dosis = dosis +2 -- no se puede sumar pues es del tipo texto
	WHERE id_paciente = 71387 AND id_medicamento = 159;

	/* d) */

	ALTER TABLE consultorio 
	ALTER COLUMN interno TYPE int USING interno::integer -- es necesario pues no hay compatibilidad de texto a int

	/* e) */

	ALTER TABLE tratamiento 
	ALTER COLUMN dosis TYPE smallint USING dosis::smallint -- es necesario pues no hay compatibilidad de texto a int

	/*	2)

		indice compuesto es necesario que se busque por las dos cosas
		a) ¿En la tabla consulta es mejor tener un índice por fecha y resultado o por resultado y
		fecha? Justifique.
			es mejor tener un indice por fecha y resultado pues si es necesario realizar una busqueda de algun paciente en especifico es preferible primero 
			obtener los resultados de determinada fecha y despues que se ordene por los resultados mismos, sino si filtrara primero por resultados podriamos tener 
			resultados de una fecha muy alejada que en la que se hizo atender el paciente

		b) Si se necesita consultar, por un lado, las facturas emitidas en un determinado día, y, por
		otro lado, las facturas que aún no fueron pagadas. ¿Crearía índices? Especifique.
			Para realizar la consulta de facturas emitidas en un determinado dia es recomendable hacer un indice
			pues si no se hiciera un indice cuando se haga la consulta esta iria fila por fila, mientras que si hay
			un indice, por fecha de emsion, se ordenarian segun la fecha de emision e iria a buscar directamente desde la posicion
			de donde arrancan las facturas emitidas desde el dia que se consulta.
			Mientras que si solamente se querie buscar las facturas no pagadas no es necesario, pues el valomen de datos
			que manejaria ese indice seria muy grande si la base de datos es grande y no serviria pues el campo no es muy especifico

		d) ¿Me conviene tener un índice en la tabla tipo_estudio?
			como la tabla tiene pocos registros no es conveniente

		e)Si necesito ver todas las consultas médicas de un determinado paciente, ¿cómo crearía el
		índice?
			(no crearia un indice pues en la tabla consulta el id_paciente es una pk y entonces tiene su propio indice
			por lo que ya estaria ordenado y de rapido acceso para obtener las consultas
			realizadas por un determinado usuario) NO ESTA TAN BIEN PUES NO SE FILTRA POR ID_PACIENTE
			Es mejor realizar un indice por persona para mejorar el rendimiento pues el where se filtra por nombre y apellid
			y este es el que se hace primero, entonces asi logramos filtrar las tuplas necesarias y despues se hacen los joins

		f) Si necesito ver las facturas cuyo monto sea superior a 100.000, ¿cómo crearía el índice?
			crearia el indice de manera tal que filtraria por monto mayores a 100000, pues asi traeria todas las tuplas directamente del indice
			sin necesidad de recorrer toda la tabla pago. INDICE PARCIAL

		g) Si necesito ver todas las internaciones que realizaron los psiquiatras, ¿cómo crearía el índice?
			es como el caso del e) pero no es necesario pues la tabla de especialidad no tiene muchas tupla por lo que
			no reduciria el tamaño de la primera tabla con la que se efectuara el join.
	*/

	/*
		3)
		a) Obtenga el tiempo de planeamiento y ejecución de la consulta SQL que permita encontrar
		todas las facturas del primer trimestre del 2021.
	*/
	EXPLAIN ANALYZE SELECT * FROM factura
	WHERE fecha BETWEEN '2021-01-01' AND '2021-03-31'; -- 1070ms after index: 922.459 159.139 mejora 85,1%
	
	/*	
		b) Cree un índice por fecha en la tabla factura.
	*/
	CREATE INDEX idx_fecha_factura ON factura(fecha)
	
	/*
	
		d) Muestre el tamaño de la tabla factura y el tamaño de los índices.

	*/
	SELECT  pg_size_pretty(pg_table_size('factura')) AS tamFactura,
	pg_size_pretty(pg_table_size('idx_fecha_factura')) AS tamIndiceFactura -- aqui puedo obtener solamente el tamaño del indice creado
	
	SELECT  pg_size_pretty(pg_table_size('factura')) AS tamFactura,
	pg_size_pretty(pg_indexes_size('factura')) AS tamIndiceFactura -- aqui puedo obtener solamente el tamaño de los indices de la tabla factura
	/*
	e) Para facilitar las búsquedas cree los índices necesarios en toda la base de datos Hospital
	(analice minuciosamente el o los campos por los cuales considera que se realizarán las
	búsquedas).
	*/
	/*
	creamos este indice porque ahi tendremos un orden alfabetico y a la hora de filtrar accederemos mas rapido
	a los datos y la tabla quedara mas pequeña a la hora de hacer el join. Lo mismo para el dni
	*/
	CREATE INDEX idx_persona_apellido_nombre ON persona(apellido,nombre)
	CREATE INDEX idx_persona_dni ON persona(dni)
	
	/*
	por temas debuscar determinados periodosfacturas
	*/
	CREATE INDEX idx_factura_fecha ON factura(fecha)
	
	/*
	indice medicamento para filtrar por nombre masrapido para la receta
	*/
	CREATE INDEX idx_medicamento_nombre ON medicamento(nombre)
	
	/*
	inidce para determinar mas rapidamente los empleados actuales
	*/
	CREATE INDEX idx_empleado_fecha_baja ON empleado(fecha_baja)
	SELECT * FROM empleado
	order by nombre;
	ORDER BY piso;
	