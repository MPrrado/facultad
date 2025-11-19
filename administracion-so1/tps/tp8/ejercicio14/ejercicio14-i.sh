#!/bin/bash
clear

nombreArchivo='eventos_'
extension='.log' #opcional, comentar si no se quiere usar
carpetaSrc='/home/mprrado/resources/'
# carpetaSrc='/home/MPrrado/resources/' #----------------------------------------------------------------------PARA NOTEBOOK!!!!!----------------------------------------------------------------------

#controlamos si se paso por parametro el usuario
if [[ $# == 0 ]]; then
    echo -e "\e[31mNo ingreso un usuario por parametro para el script!\e[0m"
    # echo "No ingreso un usuario por parametro para el script"
    echo "Saliendo..."
    exit 0
fi

#verificamos si el usuario existe en el sistema
rutaCompleta="$carpetaSrc$1"
if [[ ! -e $rutaCompleta ]]; then
    echo -e "\e[31mEl usuario $1 no existe en el sistema!\e[0m"
    # echo "El usuario $1 no existe en el sistema"
    echo "Saliendo..."
    exit 0
fi

nombreArchivo=$carpetaSrc$1"/"$nombreArchivo$1$extension
while IFS=';'  read -r linea; do #ponemos el -r para que no interprete los \ como caraceter de escape dentro del archivo. Caracteres de escapes
    usuario=$(echo $linea | cut -d ';' -f3)
    # echo $usuario
    if [[ $usuario == $1 ]]; then
        echo $linea >> $nombreArchivo #/home/mprrado/resources/<usuario>/eventos_<usuario>.log
    fi
done < "./recursos/app_events.log"

echo "Datos cargados exitosamente. Directorio de guardado: "$nombreArchivo
