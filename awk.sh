#!/bin/bash

tmp=$(basename $0 .sh)

# 行と列の合計を出す関数
function pivot() {
	while getopts :rlh OPT; do
    case $OPT in
        r)  sum_col=r
            ;;
        l)  sum_col=l
            ;;
        h)  echo "usage: pivot (option) (filename) (number of rows)"
						return 0
            ;;
        \?) echo "無効なオプションです"
						return 1
            ;;
    esac
	done
	shift $((OPTIND - 1))

	file=$1
	cols=$2
	cat $file |
	# 行番号と列番号を削除
	awk 'NR!=1{$1=""; print $0}' |
	# 行と列の合計を出す
	awk '
	BEGIN{for(i=1;i<='$cols'+1;i++){a[i]=0}}
	{
		for(i=1;i<='$cols';i++){
			if(i==1){sum=0}
			if($i!="_"){
				sum+=$i
				a[i]+=$i
			}
		}
		a['$cols'+1]+=sum
		print $0,sum
	}
	END{for(i=1;i<='$cols'+1;i++){printf "%d ",a[i]} print ""}' > $tmp-pivot
	if [ ${sum_col:-r} = r ]; then
		cat $tmp-pivot
	else
		# 左指定の場合は集計列を１列目に表示
		cat $tmp-pivot |
		awk '
		BEGIN{n='$cols'+1}
		{
			for(i=1;i<=n;i++){
				if(i==1){
					printf "%s ",$n
				}else{
					j=i-1
					printf "%s ", $j
				}
			}
			print ""
		}'
	fi
}

pivot -l mtrx 10
exit 0
