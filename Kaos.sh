#!/bin/bash

# ==========================================
# AGENTE DEL CAOS - Versión Mejorada
# Organiza archivos por tipo y limpia vacíos
# ==========================================

# ---------------- FUNCIONES ----------------

crear_directorio_si_no_existe() {
    ruta_directorio="$1"
    if [ ! -d "$ruta_directorio" ]; then
        mkdir -p "$ruta_directorio"
    fi
}

mover_archivo_a_directorio() {
    ruta_archivo="$1"
    ruta_directorio_destino="$2"
    mv "$ruta_archivo" "$ruta_directorio_destino" 2>/dev/null
}

# -------------- DIRECTORIO BASE --------------

directorio_parametro="$1"

if [ -z "$directorio_parametro" ]; then
    directorio_trabajo="$(pwd)"
else
    directorio_trabajo="$directorio_parametro"
fi

if [ ! -d "$directorio_trabajo" ]; then
    echo "Error: El directorio indicado no existe."
    exit 1
fi

cd "$directorio_trabajo" || exit 1

# -------------- ESTRUCTURA DE CARPETAS --------------

nombre_carpeta_principal="ORDENADO"

ruta_carpeta_principal="$directorio_trabajo/$nombre_carpeta_principal"
ruta_carpeta_imagenes="$ruta_carpeta_principal/IMGS"
ruta_carpeta_documentos="$ruta_carpeta_principal/DOCS"
ruta_carpeta_textos="$ruta_carpeta_principal/TXTS"
ruta_carpeta_pdfs="$ruta_carpeta_principal/PDFS"
ruta_carpeta_vacios="$ruta_carpeta_principal/VACIOS"

crear_directorio_si_no_existe "$ruta_carpeta_imagenes"
crear_directorio_si_no_existe "$ruta_carpeta_documentos"
crear_directorio_si_no_existe "$ruta_carpeta_textos"
crear_directorio_si_no_existe "$ruta_carpeta_pdfs"
crear_directorio_si_no_existe "$ruta_carpeta_vacios"

echo "Organizando archivos en: $directorio_trabajo"
echo "--------------------------------------------"

# -------------- CONTADORES --------------

contador_imagenes_movidas=0
contador_documentos_movidos=0
contador_textos_movidos=0
contador_pdfs_movidos=0
contador_archivos_vacios_movidos=0
shopt -s nullglob

# -------------- CLASIFICACIÓN DE ARCHIVOS --------------

for ruta_archivo_actual in "$directorio_trabajo"/*; do

    if [ ! -f "$ruta_archivo_actual" ]; then
        continue
    fi

    nombre_archivo_actual="$(basename "$ruta_archivo_actual")"

    if [[ "$ruta_archivo_actual" == "$ruta_carpeta_principal"* ]]; then
        continue
    fi

    if [ ! -s "$ruta_archivo_actual" ]; then
        mover_archivo_a_directorio "$ruta_archivo_actual" "$ruta_carpeta_vacios/"
        ((contador_archivos_vacios_movidos++))
        continue
    fi

    extension_archivo="${nombre_archivo_actual##*.}"
    extension_archivo_minuscula="${extension_archivo,,}"

    case "$extension_archivo_minuscula" in
        jpg|png|gif)
            mover_archivo_a_directorio "$ruta_archivo_actual" "$ruta_carpeta_imagenes/"
            ((contador_imagenes_movidas++))
            ;;
        docx|odt)
            mover_archivo_a_directorio "$ruta_archivo_actual" "$ruta_carpeta_documentos/"
            ((contador_documentos_movidos++))
            ;;
        txt)
            mover_archivo_a_directorio "$ruta_archivo_actual" "$ruta_carpeta_textos/"
            ((contador_textos_movidos++))
            ;;
        pdf)
            mover_archivo_a_directorio "$ruta_archivo_actual" "$ruta_carpeta_pdfs/"
            ((contador_pdfs_movidos++))
            ;;
    esac

done


mapfile -t lista_archivos_vacios_restantes < <(find . -type f -empty ! -path "./$nombre_carpeta_principal/*")
mapfile -t lista_carpetas_vacias_restantes < <(find . -type d -empty ! -path "./$nombre_carpeta_principal")

total_elementos_vacios_restantes=$(( ${#lista_archivos_vacios_restantes[@]} + ${#lista_carpetas_vacias_restantes[@]} ))

# -------------- INFORME FINAL --------------

echo ""
echo "INFORME FINAL"
echo "--------------------------------------------"
echo "Imágenes movidas: $contador_imagenes_movidas"
echo "Documentos movidos: $contador_documentos_movidos"
echo "TXT movidos: $contador_textos_movidos"
echo "PDFs movidos: $contador_pdfs_movidos"
echo "Archivos vacíos movidos: $contador_archivos_vacios_movidos"
echo "Elementos vacíos restantes detectados: $total_elementos_vacios_restantes"

echo ""
echo "Proceso completado. Todo organizado en '$nombre_carpeta_principal/'."
