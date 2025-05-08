--EJERCICIO 5 
--A)

SELECT * FROM patologia
WHERE id_patologia = 1
/*
Luego de mostrar la patologia de nuevo, luego de haber upgradeado en el otro query tool, sigo viendo la patologia como si fuera tos
*/

--B)
START TRANSACTION ISOLATION LEVEL REPEATABLE READ; --Iniciacion una transacion con el nivel de aislamiento REPEATABLE READ

--MOSTRAMOS TODOS LOS DATOS DE LA PATOLOGIA 1
SELECT * FROM patologia
WHERE id_patologia = 1

/*
Una vez actualizada lo que veo es que sigue estando el valor anterior (mi apellido)
Luego de realizado el commit en la conexion con el usuario postgres sigo viendo el valor anterior (mi apellido)
*/

commit

/*
Luego de realizado el commmit con el usuario medico recién puedo ver el valor actualizado del usuario postgres
*/
ROLLBACK;