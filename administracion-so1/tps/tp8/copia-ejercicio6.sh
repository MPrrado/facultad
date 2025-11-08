#!/bin/bash
clear
# Crea un script que, con un número entero, muestre un mensaje por pantalla:
# a) Si es positivo.
# b) Si lo es, si está entre 5 y 10. Si no, si está entre 1 y 5.
# Sino, si es mayor que 10.
# c) Si no es positivo, si es cero.
# d) Si es negativo, si está entre -5 y -1. Si no, si es menor que -5.

read -p "Ingrese un numero: " numero

echo "El numero es:" $numero

if [ $numero -gt 0 ]; then

	echo "El numero ingresado es positivo"

	if (( $numero < 10 && $numero > 5 ||  $numero == 10 )); then

		echo "El numero esta entre  5<"$numero"<=10"
	elif [ $numero -eq 5 ] || [ $numero -lt 5 ] && [ $numero -gt 1 ] || [ $numero -eq 1 ]; then

		echo "El numero esta entre 1<="$numero"<=5"

	else

		echo "El numero ingresado es mayor que 10: 10<"$numero

	fi

elif [ $numero -eq 0 ]; then

	echo "El numero ingresado es cero"

else

	echo "El numero ingresado es negativo"

	if [ $numero -eq -5 ] || [ $numero -eq -1 ] || [ $numero -gt -5 ] && [ $numero -lt -1 ]; then

		echo "El numero ingresado esta entre -5<="$numero"<=-1"

	elif [ $numero -lt -5 ]; then

		echo "El numero ingresado es menor que -5:" $numero"<-5"

	fi

fi
