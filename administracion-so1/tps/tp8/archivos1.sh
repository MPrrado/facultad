#!/bin/bash

clear

#13. Escribe un script, llamado archivos1.sh, que realice las siguientes tareas:
#a) Pida al usuario su nombre y la ruta de un archivo (que no exista).
#b) Verifique la existencia del archivo. Si no existe, pregunte al usuario si quiere crearlo.
#c) Si el archivo existe, verifique que no está vacío y que el usuario tiene permiso de lectura y escritura.
#d) Luego, que pida al usuario ingresar una contraseña, que no debe ser visible al ingresarla, y escribir en el archivo una línea con el texto:
# <nombre>; <contraseña>.
#e) Pregunte al usuario si quiere repetir todas estas tareas, y hacerlo mientras responda que sí.
#f) Probar el script:
	#i) Con un archivo que no existe y que el script lo cree.
	#ii) Con el archivo creado

#variables auxiliares
opcion=''

#a) Pedimos al usuario su nombre y la ruta de un archivo.
read -p "Ingrese su nombre: " nombre
read -p "Ingrese la ruta del archivo: " archivo
# archivo="/home/MPrrado/ejercicio13/test3" #nos sirve para no ingresar la ruta del archivo siempre

directorioArchivo=$(dirname $archivo) #obtenemos el directorio hasta antes de la ultima /
nombreArchivo=$(basename $archivo) #obtenemos el ultimo elemento despues de la ultima / eso es lo que considera como archivo

#b) Verificamos la existencia del archivo. Si no existe preguntamos si quiere crearlo
while true; do
	if [[ $opcion =~ [s|S] ]]; then #sirve para que pida ingresar un nuevo nombre en el caso que decida seguir agregando contraseñas
		read -p "Ingrese su nombre: " nombre
	fi
	if  [[ ! -e $archivo ]]; then
		while true; do
			read -p "Desea crear el archivo (s/n): " opcion
			if [[ $opcion =~ ^[s|n|S|N]$ ]]; then
				break
			fi
		done
		if [[ $opcion == 's' ]]; then
			if [[ ! -d $(dirname $archivo) ]]; then
				echo $directorioArchivo
				mkdir -p $directorioArchivo
			fi
			echo $(basename $archivo)
			cd $directorioArchivo
			touch $nombreArchivo
		else
			echo "saliendo..."
			exit 1
		fi
	else 

		#c) verificamos que no este vacio el archivo
		if [[ ! -s $archivo ]]; then
			echo "El archivo esta vacio"
		else
			echo "El archivo NO esta vacio"
		fi

		#agregamos los permisos necesarios
		if [[ ! -r $archivo && ! -w $archivo ]]; then
			echo "No posee permisos de escritura ni de lectura. Agregandolos..."
			chmod +wr $archivo
		elif [[ ! -r $archivo && -w $archivo ]]; then
			echo "No posee permisos de lectura. Agregandolo..."
			chmod +r $archivo
		elif [[  -r $archivo && ! -w $archivo ]]; then
			echo "No posee permisos de escritura. Agregandolo..."
			chmod +w $archivo
		fi
		#d) solicitamos contraseña sin que sea visible
	fi
	sleep 5
	clear
	read -sp "Ingrese su contraseña: " pass 
	echo "$nombre;$pass" >> $archivo
	while true; do
			echo -e '\n'
			read -p "Desea continuar agregando contraseñas (s/n): " opcion
			if [[ $opcion =~ ^[s|n|S|N]$ ]]; then
				break
			fi
	done
	if [[ $opcion == 'n' ]]; then
		echo "saliendo vuelva pronto..."
		exit 1
	fi
done
