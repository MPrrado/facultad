#!/bin/bash

clear

# 11. Escribe un script, llamado funciones.sh, que implemente las siguientes funciones:
# a) Reciba un nombre y muestre por pantalla un saludo a ese nombre.
# b) Reciba dos números, los sume y devuelva el resultado.

function saludo
{

	echo "Bienvenido! "$1

}


nombre="Santiago"
saludo $nombre
