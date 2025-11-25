#!/bin/bash
clear
echo "Leyendo el archivo app_events.log..."

rutaArchivo="/home/mprrado/resources/"
rutaArchivoErrores="/home/mprrado/resources/errores_movimiento.log"
rutaArchivoProcesados="/home/mprrado/resources/processed_files"

while IFS=';'  read -r -a linea; do #ponemos el -r para que no interprete los \ como caraceter de escape dentro del archivo. Caracteres de escapes

    usuario=${linea[2]}
    archivo=${linea[3]}
    # echo $archivo
    # echo -e $usuario"\n" #test para ver si lee bien los usuarios, la sintaxis de hacer que separe la linea mediante el delimitador funciona la opcion es -a
    rutaCompletaUsuario=$rutaArchivo$usuario
    if [[ ! -d $rutaCompletaUsuario ]]; then
        echo "El usuario no está en el sistema. Saliendo..."
        exit 1
    fi
    rutaCompletaArchivo=$(find "$rutaArchivo" -not -path "*processed_files*" -name "$archivo")
    # echo $rutaCompletaArchivo
    if [[ ! -e $rutaCompletaArchivo ]]; then
        # echo "entra aqui"
        echo "fallo a copiar "$archivo >> $rutaArchivoErrores
    else
        if [[ ! -d $rutaArchivoProcesados ]]; then
            mkdir -p $rutaArchivoProcesados
        fi
        if [[ ! -d $rutaArchivoProcesados"/"$usuario ]]; then
            mkdir -p $rutaArchivoProcesados"/"$usuario
        fi
        if [[ ! -e $$rutaArchivoProcesados"/"$usuario"/"$archivo ]]; then
            cp $rutaCompletaArchivo $rutaArchivoProcesados"/"$usuario"/"
        fi
    fi

done < "../recursos/app_events.log"

echo "fin, revisar "$rutaArchivoProcesados