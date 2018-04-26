#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: $(basename $0) path1 [path2 ...]"
	exit 1
fi

make_list()
{
	while read -r f
	do
		d="$(dirname $f)"
		b="$(basename $f)"
		m="$(echo "$f" | md5sum | cut -d' ' -f1)"
		echo "$d $m $b"
	done < <(find $path -type f)
}

for path in "$@"
do
	if [ ! -e "$path" ]
	then
		echo "path[$path] not found." > /dev/stderr
		continue
	fi
	make_list "$path"
done
