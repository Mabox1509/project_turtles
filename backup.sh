#!/bin/bash

# Pedir al usuario el mensaje del commit
read -p "Escribe el mensaje para el commit: " mensaje

# Si el mensaje está vacío, usar un mensaje por defecto con fecha
if [ -z "$mensaje" ]; then
    fecha=$(date +"%Y-%m-%d %H:%M:%S")
    mensaje="Backup $fecha"
fi

# Añadir todos los cambios
git add .

# Hacer commit con el mensaje
git commit -m "$mensaje"

# Hacer push al repositorio remoto (rama actual)
git push origin HEAD

