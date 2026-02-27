#!/bin/bash

# Si no se pasa directorio, usamos el actual
if [ -z "$1" ]; then
    directorio=$(pwd)
else
    directorio="$1"
fi

if [ ! -d "$directorio" ]; then
    echo "El directorio no existe"
    exit 1
fi

cd "$directorio"

carpeta_principal="ORDENADO"

mkdir -p "$carpeta_principal/IMGS"
mkdir -p "$carpeta_principal/DOCS"
mkdir -p "$carpeta_principal/TXTS"
mkdir -p "$carpeta_principal/PDFS"
mkdir -p "$carpeta_principal/VACIOS"

imagenes=0
documentos=0
textos=0
pdfs=0
vacios=0

echo "Ordenando archivos..."
echo "----------------------"

for archivo in *; do

    if [ -f "$archivo" ]; then

        if [ ! -s "$archivo" ]; then
            mv "$archivo" "$carpeta_principal/VACIOS/"
            vacios=$((vacios + 1))

        elif [[ "$archivo" == *.jpg || "$archivo" == *.png || "$archivo" == *.gif ]]; then
            mv "$archivo" "$carpeta_principal/IMGS/"
            imagenes=$((imagenes + 1))

        elif [[ "$archivo" == *.docx || "$archivo" == *.odt ]]; then
            mv "$archivo" "$carpeta_principal/DOCS/"
            documentos=$((documentos + 1))

        elif [[ "$archivo" == *.txt ]]; then
            mv "$archivo" "$carpeta_principal/TXTS/"
            textos=$((textos + 1))

        elif [[ "$archivo" == *.pdf ]]; then
            mv "$archivo" "$carpeta_principal/PDFS/"
            pdfs=$((pdfs + 1))
        fi
    fi
done

echo ""
echo "INFORME FINAL"
echo "-------------"
echo "Imágenes: $imagenes"
echo "Documentos: $documentos"
echo "TXT: $textos"
echo "PDF: $pdfs"
echo "Vacíos movidos: $vacios"

echo ""
echo "Proceso terminado."
