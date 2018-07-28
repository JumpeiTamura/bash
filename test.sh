#!/bin/bash


func(){
	greet=hi
}


greet=hello


echo $greet

func

echo $greet


while read line; do
	if [[ "$line" =~ ^hist[0-9]+$ ]]; then
		echo history
	fi
done





