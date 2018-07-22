#!/bin/bash -xv

#begin help
#
# File name: awk.sh
#
# Written by Jumpei Tamura
#
# This is a file that tests awk script.
#
#end help

source ./ish.sh


cat test.txt |

awk '/^b/{print "bから始まる行："$0}'

cat test.txt |

awk '$2 ~ /^b/{print "2フィールド目がbから始まる行："$0}'

cat test.txt |

awk '{print NR"行目："$0}'

cat test.txt |

awk 'NR==2{print "2行目の1フィールド目："$1}'


printf "何行目を読み込みますか？"

read n

cat test.txt |

awk --assign n=$n '
	NR==n{print $0}
'

#printf "正規表現："

#read regexp

cat test.txt |

awk '
#	{print "'"$regexp"'"}
#	match($0, "'"$regexp"'"){print $0}
'

ls -l | awk '{print $1,$9}'

ls -l | awk '
	BEGIN{printf "実行権限があるファイル：\n"}
	$1 ~ /^[^d].*x/ {print $9}
'

cat test.txt |

awk '
	BEGIN{printf "3フィールド目が数字で終わる行：\n"}
	$3 ~ /[0-9]$/ {print $0}
'

ls -l | awk '
	BEGIN{printf "書き込み権限があるシェルスクリプト以外のファイル：\n"}
	$1 ~ /^[^d].*w/ \
	&& !($9 ~ /.sh$/) {print $0}
'

echo $1

[ "$1" = "-h" ] && cat $0 |
awk '
	/^#begin help/,/^#end help/ {print $0}
'

cat test.txt |
awk '
	BEGIN{print "これから行数を数えるお。"; i=0}
	{print $0; i++}
	END{print "全部で" i "行だったお。"}
'

cat test.txt |
awk '
	BEGIN{print "カンマ区切りだと区切り文字で区切って出力\n"}
	{print $1,$2,$3}
'

cat test.txt |
awk '
	BEGIN{print "スペース区切りだと文字列連結\n"}
	{print $1 $2 $3}
'

cat test.txt |
awk '
	BEGIN{OFS=";"; print "区切り文字変更"}
	{print $1,$2,$3}
'

cat test.txt |
awk '
	BEGIN{sum=0}
	{sum+=length($0)}
	END{print "全文字数：" sum}
'

cat test.txt |
awk '
	{
		split($0,a)
		for(i in a){
			array[NR,i]=a[i]
		}
	}
	END{
		for(i in array){
			print i,array[i]
		}
	}
'







