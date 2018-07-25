#!/bin/bash

#対話的シェルを埋め込む関数

ish(){
	echo $1
	local lineno=$(cat $0 | wc -l)
	if [ "$1" != "-n" ]; then
		echo "\
####################begin script####################"
	        awk '
		{print NR,$0}' $0
		echo "\
####################end script######################"
	fi
	printf "\n\n"
        printf ">"
        while read script; do
		if [[ $script =~ ^[0-9]+$ && ($script -gt 0 && $script -le $lineno ) ]]; then
			script=$(awk 'NR=='"$script"'{print $0}' $0)
			echo ">> "$script
		fi
                [[ $script =~ ^exit ]] && echo bye
                eval $script
                printf ">"
        done
}

