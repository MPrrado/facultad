#!/bin/bash
clear
#Crea un script llamado variables.sh que declare las siguientes variables locales: nombre, apellido, y edad.
#a) Muestra sus valores por pantalla.
nombre="matias"
apellido="prado"
edad=22

echo "-----------------------------------------------------------------------"

echo "mi nombre es:" $nombre
echo "mi apellido es:" $apellido
echo "mi edad es:" $edad

echo "-----------------------------------------------------------------------"

#b)Modifica el script para mostrar el usuario actual, su UID y directorio de trabajo actual, usando las variables de entorno correspondientes.

echo 'El usuario logueado actualmente es: ' $USER
echo 'El UID del usuario logueado es: '$UID
echo 'El directorio actual de trabajo es: ' $PWD

echo "-----------------------------------------------------------------------"

#c)Agrega las líneas necesarias para acceder, a un directorio y luego, retornar al directorio anterior, con la variable de entorno correspondiente

cd /etc #entramos a un directorio cualquiera

echo 'El directorio actual de trabajo es: ' $PWD

cd $OLDPWD #nos movemos al anterior directorio de trabajo

echo 'El directorio actual de trabajo es: ' $PWD
