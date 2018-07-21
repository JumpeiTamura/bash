#!/bin/bash

{
	date
	echo hello
	ls
} > result.txt

echo outer shell
str=hello
echo $str
pwd

(
	echo sub shell
	cd ..
	str=world
	echo $str
	pwd
)
echo outer shell
echo $str
pwd

fnsample(){
	pwd
	ls
}

fnsample

update_prefecture(){
	prefecture=Aomori
}

prefecture=Hokkaido
echo $prefecture
update_prefecture
echo $prefecture

local_prefecture(){
	local prefecture=Aomori
	echo $prefecture
}
prefecture=Hokkaido
echo $prefecture
local_prefecture


print_argument(){
	local foo=$1
	local bar=$2
	local baz=$3
	echo foo = $foo
	echo bar = $bar
	echo baz = $baz
	echo $@
}

print_argument aaa bbb ccc






