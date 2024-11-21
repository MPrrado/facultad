-- 3)
CREATE TABLE proveedor(
	id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni	VARCHAR(8) NOT NULL,
    domicilio VARCHAR(100),
    telefono VARCHAR(10)
);

ALTER TABLE articulo 
	ADD id_proveedor INT,
    ADD FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor);