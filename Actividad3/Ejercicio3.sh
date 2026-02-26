#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Uso: ./calculaimc.sh altura_cmpeso_kg"
	exit 1
fi

altura_cm=$1
peso=$2

altura_m=$(echo "scale=2; $altura_cm / 100" | bc)

imc=$(echo "scale=2; $peso / ($altura_m * $altura_m)" | bc)

echo "IMC = $imc"

if(( $(echo "$imc < 18.5" | bc -1) ));
then
	echo "Bajo peso"
elif (( $(echo "$imc < 25" | bc -1) ));
then
	echo "Peso saludable"
elif (( $(echo "$imc < 30" | bc -1) ));
then
	echo "Pasado del peso estandar"
else
	echo "Obesidad"
fi
