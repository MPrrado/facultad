-- a)
ALTER TABLE venta 
	MODIFY importe DECIMAL(10,2) DEFAULT(0),
	MODIFY gasto_envio DECIMAL(7,2) DEFAULT(0),
	MODIFY total DECIMAL(10,2) DEFAULT(0);
    
-- b)
ALTER TABLE detalle_venta
	MODIFY cantidad SMALLINT CHECK(cantidad > 0);
    
-- c)
ALTER TABLE prestamo
	ADD estado_multa VARCHAR(8);
    
-- d)
ALTER TABLE persona
	MODIFY domicilio VARCHAR(100) NOT NULL;
    
-- e)
ALTER TABLE origen
	MODIFY origen VARCHAR(45) UNIQUE;
    
ALTER TABLE autor
	MODIFY autor VARCHAR(50) UNIQUE;
    
ALTER TABLE editorial
	MODIFY editorial VARCHAR(50) UNIQUE;

    