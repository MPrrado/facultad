#!/bin/bash

#Escribe un script llamado cadenas.sh que haga lo siguiente:
#a) Muestre en pantalla un saludo para el usuario actual.
#b) Presente en pantalla el texto literal La variable de entorno usada es $USER.
#c) Muestre el saludo en dos líneas, pero en un solo comando: en la primera línea el saludo del 
#   apartado a), y en una segunda línea, muestre cuál es su directorio de trabajo por defecto.
#d) Repite el apartado anterior, pero muestra la ruta entre comillas.

clear

echo "Hola, Bienvenido" $USER

echo 'La variable de entorno usada es $USER'

echo "----------------------------------------------------------------------------"

echo -e "Hola, bienvenido" $USER "\nTu directorio de trabajo por defecto es" $HOME

echo -e "Hola, bienvenido" $USER "\nTu directorio de trabajo por defecto es" \"$HOME\"

