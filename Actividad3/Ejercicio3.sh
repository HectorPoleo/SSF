#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Uso: ./calculaimc.sh altura_cmpeso_kg"
	exit 1
fi

altura=$1
peso=$2

imc=$(($peso*10000/($altura*$altura)))
echo "IMC: $imc"

if [ $imc -lt 18 ]
then
	echo "Bajo peso, hay que comer mas"
elif [ $imc -lt 25 ]
then
	echo "Saludable"
elif [ $imc -lt 30 ]
then
	echo "Por encima de la media recomendable"
else
	echo "Sobrepeso"
fi
