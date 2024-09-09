#!/usr/bin/bash

cd $HOME
tar cvf copia_seguretat_$(date +'%Y-%m-%d').tar $HOME/$BIG_DATA/.security/*.csv

echo "Copia seguretat feta"
tar tvf $HOME/$BIG_DATA/.security/copia_seguretat_$(date +'%Y-%m-%d').tar


# Defineix la línia que vols afegir
nova_linia=$1

# Defineix el directori on es troben els fitxers CSV
directori="$HOME/$BIG_DATA"

cd "${directori}"

# Recorre tots els fitxers CSV del directori
for fitxer in *.csv; do
	# Crea un fitxer temporal
	tmpfile=$(mktemp)

	nom_sense_extensio=$(basename "$fitxer" .csv)
    
	# Escriu la capçalera al fitxer temporal
	head -n 1 "$fitxer" > "$tmpfile"
    
	if [[ $nom_sense_extensio == "fitxer_hores" || $nom_sense_extensio == "fitxer_hores_2016_2024" ]]; then
		# Afegeix la nova línia després de la capçalera
		echo "$nova_linia" | awk -F "	" '{print $4";"$5";"$6}' >> "$tmpfile"
		#tail -n +2 "$fitxer" >> "$tmpfile"
	elif [[ $nom_sense_extensio == "fitxer1" || $nom_sense_extensio == "fitxer1_2016_2024" ]]; then
		# Afegeix la nova línia després de la capçalera
		echo "$nova_linia" | awk -F "	" '{print $1";"$2";"$3";"$4";"$6";"$7}' >> "$tmpfile"
	elif [[ $nom_sense_extensio == "fitxer2" || $nom_sense_extensio == "fitxer2_2016_2024" ]]; then
		# Afegeix la nova línia després de la capçalera
		echo "$nova_linia" | awk -F "	" '{print $1";"$2";"$3";"$4";"$7}' >> "$tmpfile"
	elif [[ $nom_sense_extensio == "fitxer3" || $nom_sense_extensio == "fitxer3_2016_2024" ]]; then
		# Afegeix la nova línia després de la capçalera
		echo "$nova_linia" | tr "	" ";" >> "$tmpfile"
	fi

	# Afegeix la resta del contingut del fitxer original
	tail -n +2 "$fitxer" >> "$tmpfile"

	# Substitueix el fitxer original amb el fitxer temporal
	mv "$tmpfile" "$fitxer"
    
	echo "S'ha actualitzat $fitxer"
done
