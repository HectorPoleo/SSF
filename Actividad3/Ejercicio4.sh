#!/bin/bash

while true
do
    read -s -p "Contraseña: " p1
    echo
    read -s -p "Confirmar: " p2
    echo
    
    if [ "$p1" = "$p2" ]
    then
        echo "Ok"
        break
    else
        echo "ERROR"
    fi
done