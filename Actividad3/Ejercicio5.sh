#!/bin/bash

echo "1. Espacio libre (%)"
echo "2. Espacio libre tamaño"
echo "3. Usuario y maquina"
echo "4. Número usuarios"
echo "5. Espacio usado carpeta"

read opcion

case $opcion in
1) df -h ;;
2) df -h ;;
3) whoami; hostname ;;
4) wc -1 /etc/passwd ;;
5) du -sh ~ ;;
*) echo "Opcion incorrecta" ;;
esac
