/*
a) Realice un SP para el ABM (Alta-Baja-Modificación) de las especialidades. Debe recibir dos
parámetros, el primero será el nombre de la especialidad y el segundo, en el caso de
agregar o borrar un registro, la palabra “insert” o “delete” respectivamente, o en caso de
realizar una modificación, debe ser el nuevo nombre de la especialidad que debe
reemplazar al existente (el del primer parámetro). Realice las correspondientes
validaciones. Nombre sugerido: especialidad_abm.
*/

CREATE OR REPLACE PROCEDURE public.alta_especialidad(IN nombre_especialidad character varying, IN accion character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	--controlamos que no sean vacios o nulos los datos de entrada
	IF (accion IS NULL OR accion = '' OR nombre_especialidad IS NULL OR nombre_especialidad = '')  THEN
		RAISE EXCEPTION 'ERROR los datos ingresados no deben ser nulos o vacios';
	END IF;
	IF(LOWER(accion) = 'delete') THEN
		DELETE FROM especialidad WHERE especialidad = nombre_especialidad;
        IF(FOUND) THEN  
		    RAISE NOTICE 'BORRADO EXISOTO';
        ELSE
		    RAISE EXCEPTION 'NO SE PUDO INSERTAR';
		END IF;
    END IF; 
	IF(LOWER(accion) = 'insert') THEN
        INSERT INTO especialidad (id_especialidad, especialidad)
        VALUES((SELECT MAX(id_especialidad)+1 FROM especialidad), nombre_especialidad);
        IF(FOUND) THEN  
		    RAISE NOTICE 'BORRADO EXISOTO';
        ELSE
		    RAISE EXCEPTION 'NO SE PUDO INSERTAR';
		END IF;
    END IF; 
    UPDATE especialidad e SET e.especialidad = accion
    WHERE e.especialidad = nombre_especialidad;
    IF (FOUND) THEN
	    RAISE NOTICE 'ACTUALIZACION EXITOSA';
    ELSE
	    RAISE EXCEPTION 'NO SE PUDO ACTUALIZAR EL NOMBRE';
    END IF;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'ERROR: no se pudo ejecutar por %', SQLERRM;
END;
$BODY$;


