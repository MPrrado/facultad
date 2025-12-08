#!/bin/bash
clear

ubicacionCarpetaRecursos="./lista_eventos/prado_matias" #coloco la ruta de la carpeta donde se almacenaran los archivos del script, coloco el directorio actual para que donde se ejecute se cree
ubicacionLog="$HOME/app_events.log"
if [[ ! -d $ubicacionCarpetaRecursos ]]; then #verficamos si no existe la carpeta donde se guardaran los .txt para crearla
    mkdir -p $ubicacionCarpetaRecursos
fi

while read -r linea; do #leemos linea a linea separandola en un vector segun el IFS (delimitador)
    
    codigoEvento=$(echo $linea | cut -d ";" -f1) #separo mediante comando cut el primer campo (codigo)

    if [[ ! -e $ubicacionCarpetaRecursos"/"$codigoEvento".txt" ]]; then #verificamos si no existe un archivo txt con el codigo del evento
        echo "carpeta: "$ubicacionCarpetaRecursos"/"$codigoEvento".txt creada" 
        touch $ubicacionCarpetaRecursos"/"$codigoEvento".txt" #creamos el txt
    fi
    echo $linea >> $ubicacionCarpetaRecursos"/"$codigoEvento".txt" # colocamos como primera linea la linea que se leyó
    
done < $ubicacionLog
    