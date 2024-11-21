CREATE TABLE deudores(
id_socio INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
domicilio VARCHAR(100) NOT NULL,
id_ciudad INT NOT NULL,
monto_total_adeudado DECIMAL(10,2),
FOREIGN KEY(id_socio) REFERENCES socio(id_socio) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad) ON DELETE CASCADE ON UPDATE CASCADE
);


SELECT id_socio, nombre, domicilio, id_ciudad, (SUM(monto) + COALESCE(SUM(multa),0)) AS monto_total_adeudado FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN prestamo USING (id_socio)
GROUP BY id_socio; 

START TRANSACTION;

INSERT INTO deudores (id_socio,nombre,domicilio,id_ciudad,monto_total_adeudado)
SELECT id_socio, nombre, domicilio, id_ciudad, (SUM(monto) + COALESCE(SUM(multa),0)) AS monto_total_adeudado FROM socio s
INNER JOIN persona p ON s.id_socio = p.id_persona
INNER JOIN prestamo USING (id_socio)
GROUP BY id_socio; 
ROLLBACK;
