#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: $(basename $0) path1 [path2 ...]"
	exit 1
fi

CMD_HASH=${CMD_HASH:-md5sum}

convert()
{
	#d="$(dirname "$1")"
	#b="$(basename "$1")"
	#m="$(echo "$1" | $CMD_HASH | cut -d' ' -f1)"

	#echo "$d $m $b"
	#echo "$m $1"

	$CMD_HASH $1
}

make_dir_list()
{
	while read -r line
	do
		convert "$line" "D"
	done < <(find $path -type d | sort)
}

make_file_list()
{
	while read -r line
	do
		convert "$line" "F"
	done < <(find $path -type f | grep -v '@__thumb' | sort)
}

for path in "$@"
do
	if [ ! -e "$path" ]
	then
		echo "path[$path] not found." > /dev/stderr
		continue
	fi
	#make_dir_list "$path"
	make_file_list "$path"
done
