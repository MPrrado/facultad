    #!/bin/bash

# Crear carpeta principal "resources"
mkdir -p resources

# Lista de usuarios
users=("Syd" "Roger" "David" "Richard" "Nicholas")

# Archivos asociados a cada usuario
files_by_user=(
    "syd1.txt syd2.txt syd3.txt"
    "roger1.txt roger2.txt roger3.txt"
    "david1.txt david2.txt david3.txt"
    "richard1.txt richard2.txt richard3.txt"
    "nicholas1.txt nicholas2.txt nicholas3.txt"
)

# Crear subdirectorios y mover los archivos correspondientes
for i in "${!users[@]}"; do
    user="${users[i]}"
    mkdir -p "resources/$user" # Crear subdirectorio para el usuario
    for file in ${files_by_user[i]}; do
        touch "resources/$user/$file" # Crear archivo vacío
    done
done

echo "Estructura creada en el directorio 'resources'."
