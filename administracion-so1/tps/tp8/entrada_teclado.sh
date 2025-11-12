#!/bin/bash
#12. Crea un script, llamado entrada_teclado.sh, que permita ingresar datos por teclado:
#a) Pida al usuario su nombre y apellido, y los muestre por pantalla.
#b) Ingresa los mismos datos, pero en un solo comando.
#c) Repite lo anterior, pero el mensaje que pide el dato incluido en el comando de ingreso.

clear

read -p "Ingrese su nombre: " nombre

read -p "Ingre su apellido: " apellido

echo "Su apellido y nombre: "$apellido $nombre

read -p "Ingrese nuevamente su apellido y nombre (a la vez separada por un espacio): " apellido nombre

echo "Su apellido y nombre: "$apellido $nombre
