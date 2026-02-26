#!/bin/bash

if [$# -eq 0]; then
	echo "Uso: ./commit.sh \"mensaje de commit\""
	exit 1
fi

mensaje="$*"

git add .
git commit -m "$mensaje"
git push

echo "Cambios confirmados"
