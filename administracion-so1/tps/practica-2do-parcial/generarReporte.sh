te dejo la solucion de mi ejercicio 1:
#!/bin/bash

# El script debe recibir obligatoriamente un nombre de usuario como parámetro (ej: ./auditoria_usuario.sh Nicholas). Si no se recibe, debe mostrar un mensaje de uso y salir.

# Debes crear una función llamada verificar_usuario que reciba el nombre y devuelva 0 (true) si el usuario existe dentro del archivo app_events.log, o 1 (false) si no.

# Debes crear otra función llamada generar_reporte que reciba el nombre. Esta función creará un archivo llamado reporte_<usuario>.txt en el directorio actual, conteniendo solo las líneas de ese usuario donde el evento sea "Inicio de sesion" (o cualquier evento específico).

# El bloque principal del script debe llamar a estas funciones lógicamente.
clear

rutaArchivoLog=$HOME"/app_events.log"

function verificarUsuario {
    bandera=1
    while IFS=';' read -r linea; do
        usuario=$(echo $linea | cut -d ";" -f3)
        if [[ $usuario == $1 ]]; then
            bandera=0
            break
        fi
    done < $rutaArchivoLog
    echo $bandera
}

function generarReporte {
    if [[ ! -e "reporte_$1.txt" ]]; then
        echo "generando el archivo: reporte_$1.txt ..."
        touch "reporte_$1.txt"
    fi
    while IFS=';' read -r linea; do
        usuario=$(echo $linea | cut -d ";" -f3)
        if [[ $usuario == $1 ]]; then
            echo $linea >> "reporte_$1.txt"
        fi
    done < $rutaArchivoLog
}
if [[ $# != 0 ]]; then
    if [[ $# == 1 ]]; then
        # echo $1
        existe=$(verificarUsuario $1)
        if [[ $existe == 0 ]]; then
        generarReporte $1
        else
        echo "El usuario ingresado no existe"
        fi
    else
        echo "Se ha pasado mas de un parametro"
    fi
else
echo "No se han pasado parámetros"
fi