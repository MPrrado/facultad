#!/bin/bash
clear

read -p "Ingrese un directorio a respaldar: " directorio

directorioBackups=$HOME"/copias_seguridad"

if [[ ! -d $directorioBackups ]]; then
    mkdir -p $directorioBackups
fi

if [[ ! -d $HOME"/"$directorio ]]; then
    echo -e "\n Error el directorio ingresado no existe"
    exit 1
else
    echo $directorio
    nombreBackup=$(echo $directorio"_backup.tar.gz")
    tar -czvf $nombreBackup -C $HOME $directorio
    mv $nombreBackup $HOME"/copias_seguridad"
fi
