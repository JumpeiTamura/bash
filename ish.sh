#!/bin/bash

#ファイルと行数を受け取って指定した行を返す関数
#$scriptに直接代入
get_line(){
        local file=$1
        local num=$2
        local lineno=$(cat $file | wc -l)
        if [[ $num =~ ^[0-9]+$ ]]; then
                if [[ $num -lt 0 || $num -gt $lineno ]]; then 
                        echo "行数が範囲を超えています"
			script=:
                        return 0
                fi
                script=$(awk 'NR=='$num'{print $0}' $file)
                echo ">> "$script
        fi
}

#ファイルを行数付きで出力する関数
print_with_lineno(){
	local file=$1
	local text=$2
	echo "#################### begin $text ####################"
	awk '{print NR,$0}' $file
	echo "#################### end $text ######################"
}


#対話的シェルを埋め込む関数
ish(){
	file=$0
	if [ "$1" != "-n" ]; then
		print_with_lineno $file script
	fi
	printf "\n\n> "
        while read script; do
		if [[ $script =~ ^[0-9]+$ ]]; then
			get_line $file $script
		elif [[ $script =~ ^h$ ]]; then
			echo
			print_with_lineno ish.hist history
			printf "\n\n> "
			continue
		elif [[ $script =~ ^h[0-9]+$ ]]; then
			get_line ish.hist ${script:1}
		fi
                [[ $script =~ ^exit ]] && echo bye
                eval $script
		if [[ $? -eq 0 && $script != "" && $script != ":" ]]; then
			echo $script >> ish.hist
		fi
                printf "> "
        done
}
















