#!/bin/bash

#printf "file name:"
#read input

#touch $input

cat << EOS |
hokkaido sapporo
kanagawa yokohama
miyagi sendai
tochigi utsunomiya
EOS

while read key value; do
	echo $key $value
done

test=test

printf ">"
while read script; do
	eval $script
	printf ">"
done
