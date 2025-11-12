#!/bin/bash
#11. Escribe un script, llamado funciones.sh, que implemente las siguientes funciones:
#a) Reciba un nombre y muestre por pantalla un saludo a ese nombre.
#b) Reciba dos números, los sume y devuelva el resultado.

function saludo {

	echo "hola. Bienvenido" $1

}

nombre="matias" #puedo usar esta variable o directamente mandarle el nombre de la siguiente forma "nombre"

saludo $nombre

function suma
{

	echo $(($1+$2)) #asi logro imprimir el resultado de la suma de los parametros

}

resultado=$(suma 1 2) #asi obtengo el resultado sin que salga por la salida estandar

echo "La suma es: "$resultado
