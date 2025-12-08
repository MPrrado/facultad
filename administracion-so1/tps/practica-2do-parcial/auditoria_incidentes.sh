#!/bin/bash
clear
# Enunciado: Escribe un script llamado auditoria_incidentes.sh.
# Estructura: Crea una carpeta llamada ~/auditoria y dentro de ella dos subcarpetas: graves y leves.
# Lectura: Lee el archivo app_events.log línea por línea.
# Lógica de Clasificación: Debes analizar la Columna 2 (Descripción del error).
# Si el error es "Permiso denegado" o "Conexión interrumpida", se considera un incidente GRAVE.
# Cualquier otro error ("Archivo no encontrado", "Formato inválido", etc.) se considera LEVE.
# Acción por Incidente:
# Si es Grave: Genera un archivo dentro de la carpeta graves con el nombre del usuario (ej: graves/Nicholas.log) y escribe ahí la línea completa del error.
# Si es Leve: Simplemente incremente un contador general de incidentes leves.
# Función Obligatoria: Debes crear una función llamada obtener_categoria que reciba la descripción del error (ojo: tiene espacios) y devuelva por echo la palabra "GRAVE" o "LEVE". El script principal debe usar el resultado de esta función para decidir qué hacer.
# Reporte Final: Al terminar de leer el archivo, muestra por pantalla: "Se detectaron X incidentes leves archivados.".
# Pista Clave: Como la descripción tiene espacios (ej: Permiso denegado), cuando pases ese argumento a la función, ¡asegúrate de usar comillas dobles! funcion "$variable".

rutaArchivoLog=$HOME"/app_events.log"
erroresGraves=("Permiso denegado", "Formato inválido")
if [[ ! -d $HOME"/auditoria" ]]; then
    mkdir "$HOME/auditoria"
fi

function obtenerCategoria {
    bandera=0

    for error in "${erroresGraves[@]}"; do
        if [[ "$error" == "$1" ]]; then
            bandera=1
        fi
    done
    
    if [[ $bandera == 1 ]]; then
        echo "GRAVE"
    else
        echo "LEVE"
    fi
}

mkdir -p $HOME/auditoria/{graves,leves}

contadorErroresLeves=0

while IFS=";" read -r codigo error usuario resto; do
    tipo=$(obtenerCategoria "$error")
    lineaCompleta=$codigo";"$error";"$usuario";"$resto
    if [[ $tipo == "GRAVE" ]]; then
        echo $lineaCompleta >> "$HOME/auditoria/graves/$usuario.log"
    else
        contadorErroresLeves=$(($contadorErroresLeves+1))
    fi
done < $rutaArchivoLog

echo -e "\nSe encontraron: $contadorErroresLeves errores leves"