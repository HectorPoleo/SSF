#!/bin/bash

read -p "Altura : " altura

for ((i=1;i<=altura;i++))
do
	for ((k=altura;k>i;k--))
	do
		echo -n " "
	done
	for ((j=1;j<=2*i-1;j++))
	do
		echo -n "*"
	done
	echo
done
