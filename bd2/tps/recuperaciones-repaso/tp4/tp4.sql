/*
a)Modifique el precio de todos los medicamentos cuya clasificación sea “ANTIINFECCIOSOS” (de cualquier tipo),
siguiendo los siguientes criterios según el laboratorio. Tenga en cuenta que si el porcentaje es positivo el precio del
producto sufre un aumento, de lo contrario un descuento.
*/

START TRANSACTION;

	UPDATE public.medicamento med
	SET precio=precio * 1.05
	WHERE id_laboratorio =(SELECT id_laboratorio FROM laboratorio WHERE laboratorio LIKE '%ABBOTT LABORATORIOS%') AND 
	id_clasificacion IN (SELECT id_clasificacion FROM clasificacion WHERE clasificacion LIKE '%ANTIINFECCIOSOS%')
	SAVEPOINT a;

	UPDATE public.medicamento med
	SET precio=precio * 0.975
	WHERE id_laboratorio =(SELECT id_laboratorio FROM laboratorio WHERE laboratorio LIKE 'BRISTOL CONSUMO') AND 
	id_clasificacion IN (SELECT id_clasificacion FROM clasificacion WHERE clasificacion LIKE '%ANTIINFECCIOSOS%')
	SAVEPOINT b;

	UPDATE public.medicamento med
	SET precio=precio * 0.955
	WHERE id_laboratorio =(SELECT id_laboratorio FROM laboratorio WHERE laboratorio LIKE 'FARMINDUSTRIA') AND 
	id_clasificacion IN (SELECT id_clasificacion FROM clasificacion WHERE clasificacion LIKE '%ANTIINFECCIOSOS%')
	SAVEPOINT c;

	UPDATE public.medicamento med
	SET precio=precio * 1.07
	WHERE id_laboratorio IN (SELECT id_laboratorio FROM laboratorio WHERE laboratorio NOT IN ('ABBOTT LABORATORIOS', 'BRISTOL CONSUMO', 'FARMINDUSTRIA')) AND 
	id_clasificacion IN (SELECT id_clasificacion FROM clasificacion WHERE clasificacion LIKE '%ANTIINFECCIOSOS%')
	SAVEPOINT d;
COMMIT;

/*
Ejercicio nro. 2:
Dé de alta un nuevo paciente con los siguientes datos:
Paciente: PEREZ, JUAN
DNI: 31.722.586
Fecha de nacimiento: 20/08/1984
Domicilio: AV. MITRE 643
Teléfono: 54-381-326-1780
Obra Social: OBRA SOCIAL DE LOCUTORES
*/

START TRANSACTION;
	INSERT INTO public.persona(	id_persona, nombre, apellido, dni, fecha_nacimiento, domicilio, telefono)
	VALUES ((SELECT MAX(id_persona) + 1 FROM persona), 'JUAN', 'PEREZ', '31722586', '1984-08-20', 'AV. MITRE 643', '543813261780');
	
	SAVEPOINT INSERT_PERSONA;

	INSERT INTO public.paciente(id_paciente, id_obra_social)
	VALUES ((SELECT MAX(id_persona) FROM persona), (SELECT id_obra_social FROM obra_social WHERE nombre LIKE '%OBRA SOCIAL DE LOCUTORES%'));
	
	SAVEPOINT INSERT_PACIENTE

	SELECT * FROM persona ORDER BY id_persona DESC
	SELECT * FROM PACIENTE ORDER BY ID_PACIENTE DESC
	SELECT * FROM OBRA_SOCIAL WHERE id_obra_social = 95
COMMIT;

/*
Agregue la siguiente información a la base de datos:
Al paciente PEREZ, JUAN con DNI: 31.722.586 se lo intervino de la siguiente manera:
a) El día 15/04/2025 la doctora ROJO, EVA le realizó el estudio ESPIROMETRIA COMPUTADA usando un
LARINGOSCOPIO, dicho estudio dio como resultado NORMAL y como observación NO SE OBSERVAN
IRREGULARIDADES. El costo de este estudio es de 3.280,00.
b) El día 16/04/2025 la doctora ALBORNOZ, PAULA DANIELA dio la orden de internación y se le asignó la
cama 157.	
c) El día 16/04/2025 la misma doctora le indica el siguiente tratamiento:
• Nombre: AFRIN ADULTOS SOL – Descripción: FRASCO X 15 CC – Dosis: 1 – Costo: 1.821,79
• Nombre: NAFAZOL – Descripción: FRASCO X 15 ML – Dosis: 2 – Costo: 1.850,96
• Nombre: VIBROCIL GOTAS NASALES – Descripción: FRASCO X 15 CC – Dosis: 2 – Costo: 2.500,66
d) El día 19/04/2025 a las 11:30am se le da de alta. Esos 3 días de internación tienen un costo de
120.000,00.
*/

START TRANSACTION;
	--a)
	INSERT INTO public.estudio_realizado(id_paciente, id_estudio, fecha, id_equipo, id_empleado, resultado, observacion, precio)
	VALUES ((SELECT id_persona FROM persona WHERE dni = '31722586'), (SELECT id_estudio FROM estudio WHERE nombre LIKE 'ESPIROMETRIA COMPUTADA'), '2025-04-15', (SELECT id_equipo FROM equipo WHERE nombre LIKE 'LARINGOSCOPIO'), (SELECT id_persona FROM persona WHERE nombre = 'EVA' AND apellido = 'ROJO'), 'NORMAL', 'NO SE OBSERVAN
IRREGULARIDADES', 3280.00);
	
	SELECT * FROM estudio_realizado ORDER BY fecha DESC
	
	SAVEPOINT insert_estudio_realizado;

	--b
	INSERT INTO public.internacion(id_paciente, id_cama, fecha_inicio, ordena_internacion)
	VALUES ((SELECT id_persona FROM persona WHERE dni = '31722586'), 157, '2025-04-16', (SELECT id_persona FROM persona WHERE nombre = 'PAULA DANIELA' AND apellido = 'ALBORNOZ'));

	SELECT * FROM internacion ORDER BY fecha_inicio DESC

	SAVEPOINT insert_internacion;

	--c
	INSERT INTO public.tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
	VALUES ((SELECT id_persona FROM persona WHERE dni = '31722586'), (SELECT id_medicamento FROM medicamento WHERE nombre LIKE 'AFRIN ADULTOS SOL'), '2025-04-16', (SELECT id_persona FROM persona WHERE nombre = 'PAULA DANIELA' AND apellido = 'ALBORNOZ'), 'AFRIN ADULTOS SOL', 'FRASCO X 15 CC', 1, 1821.79);

	SAVEPOINT insert_tratamiento_1
	
	INSERT INTO public.tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
	VALUES ((SELECT id_persona FROM persona WHERE dni = '31722586'), (SELECT id_medicamento FROM medicamento WHERE nombre LIKE 'NAFAZOL'), '2025-04-16', (SELECT id_persona FROM persona WHERE nombre = 'PAULA DANIELA' AND apellido = 'ALBORNOZ'), 'NAFAZOL', 'FRASCO X 15 ML', 2, 1850.96);
	
	SAVEPOINT insert_tratamiento_2
	
	INSERT INTO public.tratamiento(id_paciente, id_medicamento, fecha_indicacion, prescribe, nombre, descripcion, dosis, costo)
	VALUES ((SELECT id_persona FROM persona WHERE dni = '31722586'), (SELECT id_medicamento FROM medicamento WHERE nombre LIKE 'VIBROCIL GOTAS NASALES'), '2025-04-16', (SELECT id_persona FROM persona WHERE nombre = 'PAULA DANIELA' AND apellido = 'ALBORNOZ'), 'VIBROCIL GOTAS NASALES', 'FRASCO X 15 CC', 2, 2500.66);

	SAVEPOINT insert_tratamiento_3

	SELECT * FROM tratamiento ORDER BY fecha_indicacion DESC

	--d
	UPDATE public.internacion
	SET fecha_alta='2025-04-19', hora='11:30:00', costo=120000.00
	WHERE id_paciente = (SELECT id_persona FROM persona WHERE dni = '31722586') AND fecha_alta IS NULL;
	
	SAVEPOINT alta_internacion

	SELECT * FROM internacion ORDER BY fecha_inicio DESC
COMMIT;

/*
Ejercicio nro. 4:
Tenga en cuenta los datos del punto anterior y emita una factura al paciente PEREZ, JUAN con DNI: 31.722.586, con la
fecha de hoy por el monto total de todas las intervenciones indicadas en el punto anterior.
*/

START TRANSACTION;
	INSERT INTO factura VALUES((SELECT MAX(id_factura) + 1 FROM factura),
	 (SELECT id_persona FROM persona WHERE dni = '31722586'), current_date, current_time,
	(SELECT SUM(precio) FROM (
	SELECT precio FROM estudio_realizado WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	UNION
	SELECT costo FROM tratamiento WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	UNION
	SELECT costo FROM internacion WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	) as total), 'N',
	(SELECT SUM(precio) FROM (
	SELECT precio FROM estudio_realizado WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	UNION
	SELECT costo FROM tratamiento WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	UNION
	SELECT costo FROM internacion WHERE id_paciente =
	(SELECT id_persona FROM persona WHERE dni = '31722586')
	) as total) );
	SELECT * FROM FACTURA where id_paciente = (SELECT id_persona FROM persona WHERE dni = '31722586')
COMMIT;