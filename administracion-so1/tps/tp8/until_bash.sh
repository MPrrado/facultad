#!/bin/bash

clear

read -p "Ingrese un caracter numerico: " numero

until [[ $numero =~ ^[a-zA-Z]$ ]]; do

        echo "el numero ingresado es: "$numero

	read -p "Ingrese un caracter numerico: " numero

done

echo "El caracter ingresado no fue un numero: " $numero
