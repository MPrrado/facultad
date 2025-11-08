#!/bin/bash

clear

read -p "Ingrese un caracter numerico: " numero

echo "El numero ingresado es: "$numero

while [[ $numero =~ ^[0-9]$ ]]; do

	read -p "Ingreso un caracter numerico, puede seguir ingresando: " numero
	echo "El numero ingresado es: "$numero

done

echo "Error ingreso un caracter NO numerico: "$numero

