#!/bin/bash
clear

rutaArchivo=$HOME"/usuarios.txt"
if [[ ! -e $rutaArchivo ]]; then #si no existe el archivo lo creamos
    echo "Creando archivo en" $rutaArchivo "..."
    touch $rutaArchivo
fi

read -p "Ingrese un nombre de usuario: " usuario

while IFS=";" read -r nombre pass; do
    if [[ $usuario == $nombre ]]; then
        echo -e "\nEl usuario ingresado ya existe en el sistema. Saliendo..."
        exit 0
    fi
done < $rutaArchivo

read -sp "Ingrese la contraseña: " pass

while [[ $pass == "" ]]; do
    echo -e "\nError, la contraseña no debe ser una cadena vacia"
    read -sp "Ingrese la contraseña: " pass
done

echo $usuario";"$pass >> $rutaArchivo
echo -e "\nUSUARIO CREADO CORRECTAMENTE"
