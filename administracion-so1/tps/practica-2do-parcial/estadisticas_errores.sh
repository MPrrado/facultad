#!/bin/bash

clear

# Ejercicio 2: Arrays y Contadores (Nivel Examen)
# Objetivo: Practicar Arrays, bucles for sobre arrays y aritmética (( )).

# Enunciado: Escribe un script llamado estadisticas_errores.sh.

# Declara un array que contenga los códigos de error considerados "críticos": 456 y 963.

# Crea un directorio ~/resumen_errores.

# Lee el archivo app_events.log línea por línea.

# Por cada línea, verifica si el código del evento (1ra columna) está dentro de tu array de errores críticos.

# Si es crítico, incrementa un contador global de errores críticos.

# Al finalizar el bucle, muestra por pantalla el total de errores críticos encontrados y genera un archivo ~/resumen_errores/total.txt con ese número.

# Pista: Puedes recorrer el array dentro del while para comparar.

rutaArchivoLog=$HOME"/app_events.log"
erroresCriticos=(456 963)
contadorErroresCriticos=0
# echo "${erroresCriticos[@]}"
while IFS=";" read -r codigo restoLinea; do
    # if [[ ${erroresCriticos[@]} =~ $codigo ]]; then
    #     contadorErroresCriticos=$(($contadorErroresCriticos+1))
    # fi

    for cod in "${erroresCriticos[@]}"; do
        if [[ "$cod" == "$codigo" ]]; then
            contadorErroresCriticos=$(($contadorErroresCriticos+1))
            break
        fi
    done
done < $rutaArchivoLog

echo -e "\n La cantidad de errores criticos obtenidos fue: $contadorErroresCriticos"
if [[ ! -d $HOME"/resumenes_errores" ]]; then
    mkdir "$HOME/resumenes_errores"
fi

echo $contadorErroresCriticos > "$HOME/resumenes_errores/total.txt"