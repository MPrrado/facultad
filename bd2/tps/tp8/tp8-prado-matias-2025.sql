/*
a) Cada vez que se agregue un registro en la tabla Tratamiento debe modificar el stock del
medicamento recetado, de acuerdo a la cantidad de dosis indicada (stock = stock - dosis)

*/

--creamos la funcion que llamará al trigger
CREATE OR REPLACE FUNCTION public.resta_stock() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE medicamento SET stock = stock - new.dosis WHERE id_medicamento = new.id_medicamento;
	RETURN NEW;
END;
$BODY$;

--creamos al trigger
CREATE TRIGGER resta_stock
AFTER INSERT ON tratamiento FOR EACH ROW
EXECUTE PROCEDURE resta_stock();

-- test con el procedimiento almacenado para poder ver si se llama al trigger
CALL tratamiento_alta('18354930','FENALGINA R-NF 1500 INY','37870755', '60', 5000);


select * from tratamiento
ORDER BY fecha_indicacion DESC;

SELECT * FROM TRATAMIENTO
ORDER BY fecha_indicacion DESC
SELECT * FROM MEDICAMENTO
WHERE ID_MEDICAMENTO = 28;


/*
b) Cuando se agrega un registro a la tabla Compra debe actualizar el stock del medicamento
comprado de acuerdo a la cantidad adquirida (stock = stock + cantidad).
*/
CREATE OR REPLACE FUNCTION public.suma_stock() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE medicamento SET stock = stock + new.cantidad WHERE id_medicamento = new.id_medicamento;
	RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE TRIGGER suma_stock
    AFTER INSERT
    ON public.compra
    FOR EACH ROW
    EXECUTE FUNCTION public.suma_stock();

--test
INSERT INTO compra (id_medicamento, id_proveedor, fecha, id_empleado, precio_unitario, cantidad)
VALUES(1,1, CURRENT_DATE, 1, 2000,10);

select * from empleado
where id_empleado = 1

SELECT * FROM MEDICAMENTO
WHERE ID_MEDICAMENTO = 1;

select * from proveedor
where id_proveedor = 1


/*
c) Cada vez que se realice un pago debe modificar los campos saldo y pagada de la tabla
Factura. El campo saldo es la diferencia entre el monto de la factura y la suma de los
montos de la tabla Pago de la factura correspondiente. La columna pagada será ‘S’ si el
saldo es 0 (cero) y ‘N’ en caso contrario. Realice el control para que no permita pagar más
de lo que se debe.

*/

CREATE OR REPLACE FUNCTION public.actualizacion_pago_factura()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
    saldo_pendiente NUMERIC(10,2);
    monto_pagado NUMERIC(10,2); -- Se declara el tipo de la variable correctamente
BEGIN
    -- Asignar el valor de NEW.monto a monto_pagado
    monto_pagado := NEW.monto;

    -- Obtener el saldo pendiente de la factura
    SELECT saldo INTO saldo_pendiente FROM factura WHERE id_factura = NEW.id_factura;

    -- Validar si el monto a pagar es mayor que el saldo pendiente
    IF monto_pagado > saldo_pendiente THEN
        RAISE EXCEPTION 'ERROR: El monto ingresado supera el saldo pendiente de la factura número: %', NEW.id_factura;
    ELSIF (saldo_pendiente - monto_pagado) = 0 THEN
        -- Si el saldo se reduce a 0, marcar la factura como pagada
        UPDATE factura 
        SET pagada = 'S', saldo = 0 
        WHERE id_factura = NEW.id_factura;
    ELSE
        -- Solo reducir el saldo si aún queda deuda
        UPDATE factura 
        SET saldo = saldo - monto_pagado 
        WHERE id_factura = NEW.id_factura;
    END IF;

    RETURN NEW; -- Retornar el nuevo registro como corresponde en una función TRIGGER
END;
$$;


CREATE OR REPLACE TRIGGER actualizacion_pago_factura
    BEFORE INSERT
    ON public.pago
    FOR EACH ROW
    EXECUTE FUNCTION actualizacion_pago_factura();


INSERT INTO pago (id_factura, fecha, monto)
VALUES(2,CURRENT_DATE, 35000);


select * from factura
where id_factura = 2

select * from pago
order by fecha DESC

/*
d) Cada vez que se modifique el stock de un medicamento, si el mismo es menor a 50 se
debe agregar un registro en una nueva tabla llamada medicamento_reponer. La tabla
medicamento_reponer debe tener los siguientes campos: id_medicamento, nombre,
presentación y el stock del medicamento, también debe tener el último precio que se pagó
por el mismo cuando se lo compró y a qué proveedor (solo el nombre). El trigger sólo debe
activarse cuando se modifique el campo stock por un valor menor al que tenia, en caso
contrario, no debe realizar ninguna acción. Tenga en cuenta que puede darse el caso que
el registro de dicho medicamento ya exista en la tabla medicamento_reponer, en tal caso
solo debe actualizar el campo stock.
*/
CREATE OR REPLACE FUNCTION public.actualizar_stock_venta()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
	id_medicamento_n integer;
	nombre_medicamento character varying;
	presentacion_n character varying;
	precio_unitario_n numeric(10,2);
	proveedor_n character varying;
	
BEGIN
	CREATE TABLE IF NOT EXISTS public.medicamento_reponer
	(
		id_medicamento integer,
		nombre character varying(100),
		presentacion character varying(100),
		stock integer,
		precio_unitario numeric(10, 2),
		proveedor character varying(50),
		PRIMARY KEY (id_medicamento)
	);

	ALTER TABLE IF EXISTS public.medicamento_reponer
		OWNER to postgres;
		
	IF(NEW.stock < 50)THEN
		IF(NOT EXISTS(SELECT id_medicamento FROM medicamento_reponer WHERE id_medicamento = NEW.id_medicamento)) THEN
		
			SELECT id_medicamento INTO id_medicamento_n FROM medicamento WHERE id_medicamento = NEW.id_medicamento;
			SELECT nombre INTO nombre_medicamento FROM medicamento WHERE id_medicamento = NEW.id_medicamento;
			SELECT presentacion INTO presentacion_n FROM medicamento WHERE id_medicamento = NEW.id_medicamento;
			SELECT precio_unitario INTO precio_unitario_n FROM compra WHERE id_medicamento = NEW.id_medicamento ORDER BY fecha DESC LIMIT 1;
			
			SELECT proveedor INTO proveedor_n FROM compra 
			INNER JOIN proveedor USING(id_proveedor)
			WHERE id_medicamento = NEW.id_medicamento
			ORDER BY fecha DESC LIMIT 1;
	
			
			INSERT INTO medicamento_reponer (id_medicamento, nombre, presentacion, stock, precio_unitario, proveedor)
			VALUES(id_medicamento_n, nombre_medicamento, presentacion_n, NEW.stock, precio_unitario_n, proveedor_n);
			IF(FOUND)THEN
				RAISE NOTICE 'se agrego a la tabla medicamento_reponer una entrada';
			END IF;
		ELSE
		-- en caso de ya tener una tupla cargada con el medicamento solo le modifico el stock dentro de la tabla
			UPDATE medicamento_reponer 
			SET stock = NEW.stock
			WHERE id_medicamento = NEW.id_medicamento;
			IF(FOUND)THEN
				RAISE NOTICE 'se modifco una entrada en la tabla medicamento_reponer';
			END IF;
		END IF;
	END IF;
    RETURN NEW; -- Retornar el nuevo registro como corresponde en una función TRIGGER
END;
$$;


CREATE OR REPLACE TRIGGER actualizar_stock_venta
    AFTER UPDATE
    ON public.medicamento
    FOR EACH ROW WHEN (NEW.stock < OLD.stock )
    EXECUTE FUNCTION actualizar_stock_venta();

--test
select * from medicamento_reponer

/*
e) Cada vez que se modifique el stock de un medicamento, solo si es por un valor mayor al
que tenía, debe buscar si existe el registro en la tabla medicamento_reponer, y si el nuevo
valor del stock es mayor a 50, debe eliminar el registro de dicha tabla, de lo contrario,
debe modificar el campo stock de la tabla medicamento_reponer por el nuevo stock de la
tabla medicamento.
*/
CREATE OR REPLACE FUNCTION public.actualizar_stock_compra()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
	IF EXISTS(SELECT id_medicamento FROM medicamento_reponer WHERE id_medicamento = NEW.id_medicamento)THEN
		IF(NEW.stock > 50) THEN

			DELETE FROM medicamento_reponer WHERE id_medicamento = NEW.id_medicamento;
		
			IF(FOUND)THEN
				RAISE NOTICE 'se elimino el medicamento cuyo stock no esta para reponer de la tabla medicamento_reponer';
			END IF;
		ELSE
			UPDATE medicamento_reponer 
			SET stock = NEW.stock
			WHERE id_medicamento = NEW.id_medicamento;
			IF(FOUND)THEN
				RAISE NOTICE 'se modifco una entrada en la tabla medicamento_reponer';
			END IF;
		END IF;
	END IF;
    RETURN NEW; -- Retornar el nuevo registro como corresponde en una función TRIGGER
END;
$$;

CREATE OR REPLACE TRIGGER actualizar_stock_compra
    AFTER UPDATE
    ON public.medicamento
    FOR EACH ROW WHEN(NEW.stock > OLD.stock)
    EXECUTE FUNCTION actualizar_stock_compra();

--test
update MEDICAMENTO 
set stock = 51
WHERE ID_MEDICAMENTO = 28;

select * from medicamento_reponer;

/*
f) Cada vez que a un paciente le realicen un estudio, tratamiento o internación, se debe
insertar un registro en una nueva tabla llamada facturacion_pendiente, la misma debe
tener los campos id_paciente, nombre, apellido, uno que indique la práctica realizada
(estudio, tratamiento, internación), costo y fecha (la del sistema). Si en la tabla
facturacion_pendiente ya existe un registro de ese paciente y la nueva práctica realizada,
se deberá modificar el costo para sumarle el de la nueva práctica y actualizar la fecha por
la del sistema. 
*/