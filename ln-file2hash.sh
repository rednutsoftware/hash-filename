#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: $(basename $0) hash-filename.txt [basedir]"
	exit 1
fi

if [ $# -gt 1 ]
then
	bd="$2"
else
	bd="__HASHED__"
fi

while read -r m p
do
	if [ ! -f "$p" ]
	then
		echo "link target [%p] not found"
		continue
	fi
	d="$bd/${m:0:1}/${m:1:1}/${m:2:1}/${m:3:1}"
	mkdir -m 777 -p "$d" 2> /dev/null
	ln "$p" "$d/$m"
done < $1
