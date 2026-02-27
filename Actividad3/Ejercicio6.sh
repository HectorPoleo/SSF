#!/bin/bash

read -p "Base: " base
read -p "Altura: " altura

area=$((base * altura))
echo "Area: $area"

for ((i=1;i<=altura;i++))
do
	for ((j=1;j<=base;j++))
	do
		echo -n "#"
	done
	echo
done
