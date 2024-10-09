#!/bin/bash
# Creates directory to save individual files
mkdir genes
archivo="Genes.csv"
# Obtener el encabezado fuera del bucle
encabezado=$(awk NR==1 G6PD_coordinates_sacbe.varfile.ex.EDITED)
# Itera a través de cada línea en el archivo (omitir la primera línea con sed)
tail -n +2 "$archivo" | while IFS=$'\t' read -r GENE CHR START END; do
    chrom=$(echo "$CHR" | tr -cd '[:alnum:]')
    archivo_entrada="/mnt/Timina/cgonzaga/ahernandezm/g6pd/sacbe_genes/G6PD_coordinates_sacbe.varfile.ex.EDITED"
    archivo_salida="/mnt/Timina/cgonzaga/ahernandezm/g6pd/sacbe_genes/genes/${GENE}_sacbe.tsv"
    # Filtrar y agregar líneas al archivo de salida
    echo "$encabezado" > "$archivo_salida"
    #busca coincidecias PARCIALES (PSEN1,PSEN1)
    awk -F'\t' -v GENE="$GENE" '$18 ~ GENE' "$archivo_entrada" >> "$archivo_salida"
done
