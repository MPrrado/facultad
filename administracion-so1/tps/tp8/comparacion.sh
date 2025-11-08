#!/bin/bash
clear

#Crea un script llamado comparación.sh que declare dos variables numéricas.
numero1=-30
numero2=-98

#a) Verifica si las variables son iguales, cuáles es mayor o menor.

echo "COMPARANDO LOS NUMEROS:" $numero1 "y" $numero2

if [ $numero1 -eq $numero2 ]; then

	echo "el numero" $numero1 "es igual a" $numero2

elif [ $numero1 -lt $numero2 ]; then

	echo "El numero" $numero1 "es menor que" $numero2

else 

	echo "El numero" $numero1 "es mayor que" $numero2

fi

echo "-----------------------------------------------------------------"

#b) Controla si alguna de las variables es positiva o negativa y muestra un mensaje por pantalla.

echo "COMPARAMOS SI LOS NUMEROS" $numero1 "y" $numero2 "SON POSITIVOS O NEGATIVOS"

if [ $numero1 -lt 0 ] && [ $numero2 -lt 0 ]; then

	echo "Los numeros son negativos"

elif [ $numero1 -gt 0 ] && [ $numero2 -gt 0 ]; then

	echo "Los numeros son positivos"

elif [ $numero1 -lt 0 ] && [ $numero2 -gt 0 ]; then

	echo "El numero" $numero1 "es negativo y el numero" $numero2 "positivo"

else

	echo "El numero" $numero2 "es negativo y el numero" $numero1 "positivo"

fi
