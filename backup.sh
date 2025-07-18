#!/bin/bash

# Obtener la fecha actual en formato YYYY-MM-DD HH:MM:SS
fecha=$(date +"%Y-%m-%d %H:%M:%S")

# Añadir todos los cambios
git add .

# Hacer commit con mensaje que incluye la fecha
git commit -m "Backup $fecha"

# Hacer push al repositorio remoto (rama actual)
git push origin HEAD

