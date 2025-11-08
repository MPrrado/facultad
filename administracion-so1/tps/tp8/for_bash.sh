#!/bin/bash

clear

# Crea un script, llamado for_bash.sh, que muestre:
# a) Los elementos de un arreglo de cadenas: “Juan”, “Paco”, “Pedro”, “de la Mar”.
# b) Los elementos de un arreglo de números: 354, 443, 3128, 789, 802.
# c) Los N primeros números enteros.
# d) Además del tipo de datos del arreglo, ¿qué otra diferencia hay en el script?

for nombre in "Juan" "Paco" "Pedro" "de la Mar"; do

	echo "Nombre: "$nombre

done

echo ""

for numero in 354 443 3128 789 802; do

	echo "Numero: "$numero

done

echo ""

echo "MUESTRA DE LOS N PRIMERO NUMEROS ENTEROS"

n=10

for (( i=1; i<=n; i++ )); do

	echo $i

done

echo""
