#!/bin/bash

# ==============================
# AGENTE DEL CAOS - kaos.sh
# ==============================

# ---------- FUNCIONES ----------

crear_directorio() {
    [ ! -d "$1" ] && mkdir -p "$1"
}

mover_archivo() {
    mv "$1" "$2" 2>/dev/null
}

if [ -z "$1" ]; then
    DIR=$(pwd)
else
    DIR="$1"
fi

if [ ! -d "$DIR" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi

cd "$DIR" || exit 1

echo "Ordenando directorio: $DIR"
echo "--------------------------------"

imgs=0
docs=0
txts=0
pdfs=0
vacios=0

crear_directorio "IMGS"
crear_directorio "DOCS"
crear_directorio "TXTS"
crear_directorio "PDFS"
crear_directorio "VACIOS"

for file in *; do
    [ -f "$file" ] || continue

    if [ ! -s "$file" ]; then
        mover_archivo "$file" "VACIOS/"
        ((vacios++))
        continue
    fi

    case "$file" in
        *.jpg|*.png|*.gif)
            mover_archivo "$file" "IMGS/"
            ((imgs++))
            ;;
        *.docx|*.odt)
            mover_archivo "$file" "DOCS/"
            ((docs++))
            ;;
        *.txt)
            mover_archivo "$file" "TXTS/"
            ((txts++))
            ;;
        *.pdf)
            mover_archivo "$file" "PDFS/"
            ((pdfs++))
            ;;
    esac
done

archivos_vacios=$(find . -type f -empty)
carpetas_vacias=$(find . -type d -empty ! -path "./IMGS" ! -path "./DOCS" ! -path "./TXTS" ! -path "./PDFS" ! -path "./VACIOS")

total_vacios=$(echo "$archivos_vacios $carpetas_vacias" | wc -w)


echo ""
echo "INFORME FINAL"
echo "--------------------------------"
echo "Imagenes movidas: $imgs"
echo "Documentos movidos: $docs"
echo "TXT movidos: $txts"
echo "PDFs movidos: $pdfs"
echo "Elementos vacios encontrados: $total_vacios"
echo "--------------------------------"

if [ "$total_vacios" -gt 0 ]; then
    echo ""
    echo "Elementos vacios detectados:"
    echo "--------------------------------"
    echo "$archivos_vacios"
    echo "$carpetas_vacias"
    echo "--------------------------------"

    read -p "¿Deseas eliminarlos? (s/n): " respuesta

    if [[ "$respuesta" =~ ^[sS]$ ]]; then
        find . -type f -empty -delete
        find . -type d -empty -delete
        echo "Elementos vacios eliminados."
    else
        echo "No se eliminaron elementos."
    fi
fi

echo ""
echo "Limpieza completada."
