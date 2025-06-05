/*
a) Realice un SP para el ABM (Alta-Baja-Modificación) de las especialidades. Debe recibir dos
parámetros, el primero será el nombre de la especialidad y el segundo, en el caso de
agregar o borrar un registro, la palabra “insert” o “delete” respectivamente, o en caso de
realizar una modificación, debe ser el nuevo nombre de la especialidad que debe
reemplazar al existente (el del primer parámetro). Realice las correspondientes
validaciones. Nombre sugerido: especialidad_abm.
*/

CREATE OR REPLACE PROCEDURE public.especialidad_abm(IN nombre_especialidad character varying, IN accion character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	--controlamos que no sean vacios o nulos los datos de entrada
	IF (accion IS NULL OR accion = '' OR nombre_especialidad IS NULL OR nombre_especialidad = '')  THEN
		RAISE EXCEPTION 'ERROR los datos ingresados no deben ser nulos o vacios';
	END IF;
	IF(LOWER(accion) = 'delete') THEN
        CALL especialidad_baja(nombre_especialidad, accion);
	ELSIF(LOWER(accion) = 'insert') THEN
        CALL especialidad_alta(nombre_especialidad, accion);
	ELSE
    	CALL especialidad_modificacion(nombre_especialidad, accion);
	END IF;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.especialidad_alta(IN nombre_especialidad character varying, IN accion character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO especialidad (id_especialidad, especialidad)
    VALUES((SELECT MAX(id_especialidad)+1 FROM especialidad), nombre_especialidad);
    IF(FOUND) THEN  
        RAISE NOTICE 'INSERCION CON EXITO';
    ELSE
        RAISE EXCEPTION 'NO SE PUDO INSERTAR';
    END IF;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.especialidad_baja(IN nombre_especialidad character varying, IN accion character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM especialidad WHERE especialidad = nombre_especialidad;
    IF(FOUND) THEN  
        RAISE NOTICE 'BORRADO EXISOTO';
    ELSE
        RAISE EXCEPTION 'NO SE PUDO BORRAR';
    END IF;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.especialidad_modificacion(IN nombre_especialidad character varying, IN accion character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE especialidad SET especialidad = accion
    WHERE especialidad = nombre_especialidad;
    IF (FOUND) THEN
	    RAISE NOTICE 'ACTUALIZACION EXITOSA';
    ELSE
	    RAISE EXCEPTION 'NO SE PUDO ACTUALIZAR EL NOMBRE';
    END IF;
END;
$BODY$;


--test alta
CALL especialidad_abm('TEST', 'INSERT');
--test Baja
CALL especialidad_abm('TISIOLOGÍA', 'DELETE');
--test modificación
CALL especialidad_abm('TEST', 'TEST-MOD');

select * from especialidad;

/*
b) Realice un SP que permite realizar el alta en cualquiera de las tablas: patología,
clasificación y cargo. Debe recibir dos parámetros, el primero el nombre de la tabla en la
cual se quiere agregar la información y el segundo el valor del campo a agregar. Realice las
correspondientes validaciones. Nombre sugerido: tablas_sistema_alta.
*/


CREATE OR REPLACE PROCEDURE public.tablas_sistema_alta(IN nombre_tabla character varying, IN valor character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF (nombre_tabla IS NULL OR nombre_tabla = '' OR valor IS NULL OR valor = '' OR (LOWER(nombre_tabla) != 'patologia' AND LOWER(nombre_tabla) != 'clasificacion' AND LOWER(nombre_tabla) != 'cargo')) THEN
        RAISE EXCEPTION 'ERROR EL VALOR DE LOS PARAMETROS NO SON CORRECTOS, RECUERDE QUE NO DEBEN SER NULOS NI CADENAS VACIAS, TAMBIEN SOLO SON VALIDAS LAS TABLAS patologia, cargo y clasificacion';
    END IF;
    IF (LOWER(nombre_tabla) = 'patologia') THEN
        INSERT INTO patologia (id_patologia, nombre)
        VALUES ((SELECT MAX(id_patologia) + 1 FROM patologia), valor);
    END IF;
    IF (LOWER(nombre_tabla) = 'cargo') THEN
        INSERT INTO cargo (id_cargo, cargo)
        VALUES ((SELECT MAX(id_cargo) + 1 FROM cargo), valor);
    END IF;
    IF (LOWER(nombre_tabla) = 'clasificacion') THEN
        INSERT INTO clasificacion (id_clasificacion, clasificacion)
        VALUES ((SELECT MAX(id_clasificacion) + 1 FROM clasificacion), valor);
    END IF;
    IF (FOUND) THEN
        RAISE NOTICE 'CARGADO EXITOSO';
	ELSE 
		RAISE EXCEPTION 'ERROR, NO SE PUDO CARGAR LA INFORMACION';
    END IF;
    EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;

END;
$BODY$;

--test
CALL tablas_sistema_alta('CARGO', 'XD');
CALL tablas_sistema_alta('patologia', 'XD');
CALL tablas_sistema_alta('clasificacion', 'XD');
SELECT * FROM CARGO
ORDER BY ID_CARGO DESC
SELECT * FROM patologia
ORDER BY id_patologia DESC
SELECT * FROM clasificacion
ORDER BY clasificacion DESC

/*
c) Realice un SP que inserte un nuevo tratamiento, la misma recibirá 5 parámetros, el DNI del
paciente, el nombre del medicamento, el DNI del empleado (prescribe tratamiento), la
dosis y el costo. El costo y la dosis deben ser positivas y la fecha_indicacion debe ser la del
sistema. Si la dosis es mayor que el stock del medicamento prescripto, debe mostrar un
mensaje indicando que el stock es insuficiente, de lo contrario debe mostrar un mensaje
indicando si se realizó la inserción correctamente. Nombre sugerido: tratamiento_alta.
*/

CREATE OR REPLACE PROCEDURE public.tratamiento_alta(IN dni_paciente character varying, IN nombre_medicamento character varying, IN dni_empleado character varying, IN dosis_n integer, IN costo_tratamiento numeric(10,2))
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF (dni_paciente IS NULL OR dni_paciente = '' OR dni_empleado IS NULL OR dni_empleado = '' OR nombre_medicamento IS NULL OR nombre_medicamento = '') THEN
        RAISE EXCEPTION 'ERROR EL VALOR DE LOS PARAMETROS NO SON CORRECTOS, RECUERDE QUE NO DEBEN SER NULOS NI CADENAS VACIAS';
    END IF;
    IF (dosis_n < 1 OR costo_tratamiento < 1) THEN
        RAISE EXCEPTION 'ERROR EL VALOR DE LA DOSIS O DEL COSTO SON NEGATIVOS Y TIENEN QUE SER POSITIVOS';
    END IF;
    IF(dosis_n > (SELECT stock FROM medicamento WHERE nombre = nombre_medicamento)) THEN
        RAISE EXCEPTION 'ERROR EL STOCK DEL MEDICAMENTO PRESCRIPTO ES INSUFICIENTE';
    END IF;
    INSERT INTO tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
    VALUES((SELECT id_paciente FROM paciente INNER JOIN persona ON id_paciente = id_persona WHERE dni = dni_paciente), (SELECT id_medicamento FROM medicamento WHERE nombre = nombre_medicamento), CURRENT_DATE, (SELECT id_empleado FROM empleado INNER JOIN persona ON id_empleado = id_persona WHERE dni = dni_empleado), nombre_medicamento, (SELECT presentacion FROM medicamento WHERE nombre = nombre_medicamento LIMIT 1), dosis_n, costo_tratamiento );
    IF (FOUND) THEN
        RAISE NOTICE 'CARGADO EXITOSO';
	ELSE 
		RAISE EXCEPTION 'ERROR, NO SE PUDO DAR DE ALTA EL TRATAMIENTO';
    END IF;
    EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;

END;
$BODY$;

--test
SELECT * from paciente 
INNER JOIN persona ON id_paciente = id_persona;

SELECT * from empleado 
INNER JOIN persona ON id_empleado = id_persona;

select * from medicamento
ORDER BY ID_MEDICAMENTO desc;

select * from tratamiento
ORDER BY fecha_indicacion DESC;

SELECT id_paciente FROM paciente INNER JOIN persona ON id_paciente = id_persona WHERE dni = '18354930'
SELECT id_medicamento FROM medicamento WHERE nombre = 'FENALGINA R-NF 1500 INY'
CALL tratamiento_alta('18354930','FENALGINA R-NF 1500 INY','37870755', '10', 5000);

/*EJERCICIO 2*/

/*
a) Escriba una función que reciba el nombre de una obra social y devuelva un listado de
todos los pacientes que cuentan con la misma. El listado debe tener id, nombre y apellido
del paciente, sigla y nombre de la obra social.
*/

CREATE OR REPLACE FUNCTION public.obtener_listado_pacientes_obra_social(IN nombre_obra_social character varying) RETURNS SETOF obra_social_paciente
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	reg obra_social_paciente;
BEGIN
	FOR reg IN SELECT id_paciente, p.nombre, p.apellido, sigla, os.nombre FROM paciente
				INNER JOIN persona p ON id_paciente = id_persona
				INNER JOIN obra_social os USING(id_obra_social)
				WHERE os.nombre = nombre_obra_social
	LOOP
	RETURN NEXT reg;
	END LOOP;
	RETURN;
END;
$BODY$;

--test	
SELECT obtener_listado_pacientes_obra_social('OBRA SOCIAL PORTUARIOS ARGENTINOS DE MAR DEL PLATA'); -- de esta forma obtengo solamente el dato, teniendo la representacion de un solo campo

SELECT * FROM obtener_listado_pacientes_obra_social('OBRA SOCIAL PORTUARIOS ARGENTINOS DE MAR DEL PLATA'); -- de esta forma obtengo todo los datos en forma de tabla como un select normal

/*
b) Escriba una función que reciba el DNI de un paciente y devuelva todas las consultas
médicas que tuvo. Se debe mostrar el nombre y apellido del paciente, nombre y apellido
del médico que lo atendió, fecha de la consulta y nombre del consultorio.
*/

CREATE OR REPLACE FUNCTION public.obtener_consultas_paciente(IN dni_paciente character varying) RETURNS SETOF consulta_realizada
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	reg consulta_realizada;
BEGIN
	FOR reg IN SELECT pap.nombre, pap.apellido, pem.nombre, pem.apellido, fecha, c.nombre FROM consulta INNER JOIN paciente USING (id_paciente) INNER JOIN persona pap ON id_paciente = pap.id_persona INNER JOIN empleado USING(id_empleado) INNER JOIN persona pem ON id_empleado = pem.id_persona INNER JOIN consultorio c USING(id_consultorio) WHERE pap.dni = dni_paciente
	LOOP
	RETURN NEXT reg;
	END LOOP;
	RETURN;
END;
$BODY$;

--test
select * from persona
INNER JOIN PACIENTE on ID_PERSONA = ID_PACIENTE

SELECT * FROM obtener_consultas_paciente('10101457');

/*
c) Realice una función que muestre los empleados que trabajan los Feriados. Se debe
mostrar el nombre y apellido de los empleados y su especialidad. Ordenados por
especialidad. CREAR EL TIPO DE DATO ESPECIALIDAD EMPLEADO
*/

CREATE OR REPLACE FUNCTION public.obtener_empleado_trabajan_feriados() RETURNS SETOF empleado_especialidad
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	reg empleado_especialidad;
BEGIN
	FOR reg IN SELECT nombre, apellido, especialidad FROM persona
				INNER JOIN empleado ON id_persona = id_empleado
				INNER JOIN especialidad USING(id_especialidad)
				INNER JOIN trabajan USING(id_empleado)
				INNER JOIN turno USING(id_turno)
				WHERE turno = 'Feriados' AND fin IS NULL
				ORDER BY especialidad
				
	LOOP
	RETURN NEXT reg;
	END LOOP;
	RETURN;
END;
$BODY$;

select * from turno
select * from trabajan
INNER JOIN turno USING(id_turno)
where turno = 'Feriados'

--test
SELECT * FROM obtener_empleado_trabajan_feriados();

/*
d) Escriba una función que muestre el listado de las facturas indicando el número, fecha y
monto de las mismas, nombre y apellido del paciente, y una columna donde se indique un
mensaje en base al saldo pendiente. Si el saldo es menor que 500.000 en la columna se
debe mostrar “El cobro puede esperar”, si es mayor que 500.000 mostrar “Cobrar
prioridad” y si es mayor a 1.000.000 mostrar “Cobrar urgente”.
*/


CREATE OR REPLACE FUNCTION public.listado_facturas() RETURNS SETOF factura_paciente
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	reg factura_paciente;
BEGIN
	FOR reg IN SELECT id_factura, fecha, monto, nombre, apellido, caracter_de_cobro FROM paciente
				INNER JOIN (SELECT id_paciente, id_factura, fecha, monto, 'El cobro puede esperar' AS caracter_de_cobro FROM factura
							WHERE monto < 500000 AND pagada = 'N'
							UNION
							SELECT id_paciente, id_factura, fecha, monto, 'Cobrar Prioridad' AS caracter_de_cobro FROM factura
							WHERE monto > 500000 AND monto < 1000000 AND pagada = 'N'
							UNION
							SELECT id_paciente, id_factura, fecha, monto, 'Cobrar Urgente' AS caracter_de_cobro FROM factura
							WHERE monto > 1000000 AND pagada = 'N') AS T USING (id_paciente)
				INNER JOIN persona ON id_paciente = id_persona
				ORDER BY monto
	LOOP
	RETURN NEXT reg;
	END LOOP;
	RETURN;
END;
$BODY$;

--TEST
SELECT * FROM listado_facturas()

/*
e) Realice una función que liste todos los registros de alguna de las siguientes tablas: cargo,
clasificaciones, especialidad, patología y tipo_estudio. No use estructuras de control para
decidir que tabla mostrar, solo debe averiguar si el parámetro pasado a la función coincide
con el nombre de alguna de las tablas requeridas.
*/
CREATE OR REPLACE FUNCTION public.listado_tabla_simple(IN nombre_tabla character varying) RETURNS SETOF basico
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	reg basico;
	consulta character varying;
BEGIN
	IF (nombre_tabla IS NULL OR nombre_tabla = '' OR (LOWER(nombre_tabla) != 'cargo' AND LOWER(nombre_tabla) != 'clasificacion' AND LOWER(nombre_tabla) != 'especialidad' AND LOWER(nombre_tabla) != 'patologia' AND LOWER(nombre_tabla) != 'tipo_estudio')) THEN
		RAISE EXCEPTION 'ERROR EL DATO INGRESADO NO ES VALIDO, NO TIENE QUE SER NULO, NI CADENA VACIA. ADEMAS SOLO DEBEN SER LAS TABLAS "clasificacion", "especialidad", "patologia", "tipo_estudi", "cargo" ';
	END IF;
	consulta:= 'SELECT * FROM ' || quote_ident(nombre_tabla); -- el quote_ident me lo dio el copilot para evitar inyecciones, supongo que no es necesario
    
    -- Ejecutar la consulta dinámica
    FOR reg IN EXECUTE consulta
    LOOP
        RETURN NEXT reg;
    END LOOP;
	RETURN;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;

-- test
select id, dato AS cargo from listado_tabla_simple('cargo');
select id, dato AS especialidad from listado_tabla_simple('especialidad');
select id, dato AS clasificacion from listado_tabla_simple('clasificacion');
select id, dato AS patologia from listado_tabla_simple('patologia');

/*EJERCICIO 3*/

/*
Plantee e implemente una solución a la siguiente tarea.

a) Cuando se interna a un paciente se agrega un registro en la tabla internación solo con los
campos obligatorios, recién cuando se da de alta se completan los otros 3 campos de la
internación, además, se emite una factura por el monto de la internación. Implemente la
funcionalidad cuando se da de alta a un paciente.
*/

CREATE OR REPLACE FUNCTION public.alta_internacion(IN nombre_paciente character varying, IN nombre_medico character varying, IN costo_internacion numeric(10,2)) RETURNS character varying
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	id_paciente_buscado int;
	id_empleado_buscado int;
BEGIN
	IF (nombre_paciente IS NULL OR nombre_paciente = '' OR nombre_medico IS NULL OR nombre_medico = '' OR costo_internacion IS NULL) THEN
		RAISE EXCEPTION 'ERROR LOS DATOS CARGADOS NO DEBEN SER NULOS NI CADENAS VACIAS';
	END IF;

	SELECT id_paciente INTO id_paciente_buscado FROM paciente
	INNER JOIN persona ON id_paciente = id_persona
	WHERE nombre = nombre_paciente;

	
	SELECT id_empleado INTO id_empleado_buscado FROM empleado
	INNER JOIN persona ON id_empleado = id_persona
	WHERE nombre = nombre_medico;

	UPDATE internacion SET fecha_alta = CURRENT_DATE, hora = CURRENT_TIMESTAMP :: TIME(0), costo = costo_internacion
    WHERE id_paciente = id_paciente_buscado AND ordena_internacion = id_empleado_buscado AND fecha_alta IS NULL AND hora IS NULL AND costo IS NULL;
	IF (FOUND) THEN
		RETURN 'ALTA DE INTERNACION EXITOSA';
	ELSE
		RAISE EXCEPTION 'ERROR NO SE PUDO DAR DE ALTA';
	END IF;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;

select alta_internacion('HECTOR DE JESUS', 'MARIANELA IRIS DEL ROCIO', 1000000);

select * from empleado
inner join persona ON id_empleado = id_persona
where id_empleado = 200

select * from paciente
inner join persona ON id_paciente = id_persona
where id_paciente = 1000

INSERT INTO internacion(id_paciente, id_cama, fecha_inicio, ordena_internacion)
VALUES(1000,100,CURRENT_DATE, 200);
select * from internacion
order by fecha_alta desc;