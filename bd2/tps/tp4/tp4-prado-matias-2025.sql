-- ejercicio 1
BEGIN TRANSACTION;

UPDATE medicamento  SET precio = precio * 1.05
FROM clasificacion , laboratorio 
WHERE medicamento.id_laboratorio = laboratorio.id_laboratorio AND medicamento.id_clasificacion = clasificacion.id_clasificacion AND laboratorio.laboratorio LIKE '%ABBOTT LABORATORIOS%' AND clasificacion.clasificacion like '%ANTIINFECCIOSOS%'

UPDATE medicamento m SET precio = precio * 0.975
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio like '%BRISTOL CONSUMO%' AND clasificacion LIKE '%ANTIINFECCIOSOS%'


UPDATE medicamento m SET precio = precio * 0.955
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio like '%FARMINDUSTRIA%' AND clasificacion LIKE '%ANTIINFECCIOSOS%'


UPDATE medicamento m SET precio = precio * 1.07
FROM clasificacion c, laboratorio l
WHERE m.id_laboratorio = l.id_laboratorio AND m.id_clasificacion = c.id_clasificacion AND laboratorio not in ('ABBOTT LABORATORIOS', 'BRISTOL CONSUMO', 'FARMINDUSTRIA')AND clasificacion LIKE '%ANTIINFECCIOSOS%'

ROLLBACK;

START TRANSACTION;
INSERT INTO persona VALUES((SELECT MAX(id_persona) +1 FROM persona), '31722586', '1984-08-20', 'AV. MITRE 643', '54-381-326-1780
')
ROLLBACK;
--NIVEL DE AISLAMIENTO POR DEFECTO (VER TEORIA)