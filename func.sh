#!/bin/bash

set -o xtrace

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
	n=${#before[@]}
	for ((i=0; i<n; i++)); do
		sed_opts+=( "-e 1s/^${before[$i]}\(\s\)/${after[$i]}\1/g" )
		sed_opts+=( "-e 1s/\(\s\)${before[$i]}\(\s\)/\1${after[$i]}\2/g" )
		sed_opts+=( "-e 1s/\(\s\)${before[$i]}\$/\1${after[$i]}/g" )
	done
	sed ${sed_opts[@]} $file
}


#サンプルプログラム

array=(aaa bbb ccc ddd)
change_format "${array[*]}" : \( \)

declare -A before_after=(
	[before1]=after1
	[before2]=after2
	[before3]=after3
)

replace_columns "${!before_after[*]}" "${before_after[*]}" test.txt












