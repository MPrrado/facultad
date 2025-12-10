#!/bin/bash

clear

bandera=0
rutaArchivo=$HOME"/datos_personas.txt"

if [[ ! -e  $rutaArchivo ]]; then #si no existe el archivo lo creamos 
    touch $rutaArchivo
fi

until [[ $bandera == 1 ]]; do
    echo -e "\n"
    read -p "Ingrese su nombre, apellido y edad: " nombre apellido edad
    while [[ $nombre == "" || $apellido == "" || $edad -le 0 || $nombre =~ [0-9] || $apellido =~ [0-9] ]]; do
        echo -e "\nError ingrese datos validos, reviselos\n"
        read -p "Ingrese su nombre, apellido y edad: " nombre apellido edad
    done
    echo $nombre";"$apellido";"$edad >> $rutaArchivo
    echo -e "\n"
    read -p "Desea seguir ingresando nombres (S/N):" opcion
    while [[ $opcion != "s" && $opcion != "S" && $opcion != "n" && $opcion != "N" ]]; do
        echo -e "\nError debe responder solamente con las opciones validas (S/N)\n"
        read -p "Desea seguir ingresando nombres (S/N):" opcion
    done
    if [[ $opcion == "N" || $opcion == "n" ]]; then
        bandera=1
        echo -e "\n"
    fi
done

cat $rutaArchivo | sort -t ";" -k 2

# echo $nombre
# echo $apellido
# echo $edad



