#!/bin/bash

clear

# 7. Escribe un script llamado case.sh que permita ingresar un carácter, y muestre por pantalla un
# mensaje según su valor.
# a) Si es una a o una A.
# b) Si es una b.
# c) Si es una c.
# d) Si es cualquier otro carácter.

read -p "Ingrese un caracter: " caracter

while [ ${#caracter} -gt 1 ]; do
	clear
	read -p "Error, ingrese solamente 1 caracter: " caracter

done

case $caracter in

	"a" | "A")

		echo -e "El caracter ingresado es una \"A\" o \"a\""

		;;

	"b")

		echo -e "El caracter ingresado es una \"b\""

		;;

	"c")

		echo -e "El caracter ingresado es una \"c\""

		;;

	*)

		echo -e "El caracter ingresado es \""$caracter"\""

		;;

esac
