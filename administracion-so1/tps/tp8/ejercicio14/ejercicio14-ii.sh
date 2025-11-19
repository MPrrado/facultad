#!/bin/bash

clear

archivoLogs="./recursos/app_events.log"
nombreArchivoSalida="/home/mprrado/resources/resumen_errores.log"

cut -d ";" -f1 $archivoLogs | sort | uniq -c | awk '{print $2 ": " $1 " errores"}' >> $nombreArchivoSalida #el awk tiene que ir si o si con comilla simple

