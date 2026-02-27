#!/bin/bash

if [$# -ne 3]; then
	echo "Uso: $0 DIAS HORAS SEGUNDOS"
	exit 1
fi

dias=$1
horas=$2
segundos=$3

total=$((dias*86400 + horas*3600 + segundos))

echo "Segundos totales: $total"
