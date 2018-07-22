#!/bin/bash

#対話的シェルを埋め込む関数

ish(){
	echo "
####################begin script####################"
        cat $0
	echo "
####################end script######################"
	printf "\n\n"
        printf ">"
        while read script; do
                [ "$script" = "break" ] && echo bye
                eval $script
                printf ">"
        done
}

