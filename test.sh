#!/bin/bash

#配列を受け取って区切り文字を変更し、結果の文字列を返す関数

change_format(){
	local array=$1
	local separation=$2
	local bra=$3
	local cket=$4
	echo $bra${array[@]}$cket | tr " " $separation
}

#データファイルを受け取って、カラム名を変更する関数

replace_columns(){
	local before=($(echo $1))
	local after=($(echo $2))
	local file=$3
	local sed_opts=()
	echo ${before[@]}
	echo ${after[@]}
	n=${#before[@]}
	echo $n
#	head -1 file |
	for ((i=0; i<n; i++)); do
#		sed_opts+=( "-E s/^${before[$i]}\s/^${after[$i]}\s/g" )
#		sed_opts+=( "-E s/\s${before[$i]}\s/\s${after[$i]}\s/g" )
#		sed_opts+=( "-E s/\s${before[$i]}\$/\s${after[$i]}\$/g" )
		sed_opts+=( "-e s/^${before[$i]}\(\s.*\)/${after[$i]}\1/g" )
		sed_opts+=( "-e s/\(.*\s\)${before[$i]}\(\s.*\)/\1${after[$i]}\2/g" )
		sed_opts+=( "-e s/\(.*\s\)${before[$i]}\$/\1${after[$i]}/g" )
	done
	echo "${sed_opts[@]}"
	echo "${#sed_opts[@]}"
	head -1 $file |
	sed ${sed_opts[@]}
	tail -n +2 $file
}


#サンプルプログラム

array=(aaa bbb ccc ddd)
change_format "${array[*]}" : \( \)

declare -A before_after=(
	[before1]=after1
	[before2]=after2
	[before3]=after3
)

#echo ${!before_after[@]}
#echo ${before_after[@]}

replace_columns "${!before_after[*]}" "${before_after[*]}" test.txt












