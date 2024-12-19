#!/bin/bash

# example ./2.sh /Users/macriidanu/Desktop/soLab/lab7/1.sh /Users/macriidanu/Desktop/soLab/lab7

file=$1
dir=$2

if [ -z "$file" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ -z "$dir" ] || [ ! -d "$dir" ]; then
	echo "Usage: $0 <directory>"
	exit 1
fi

file_hash=$(md5sum "$file")



for File in "$dir"/*; do
	if [[ "$File" == "$file"  ]];then
		echo "$File = $file"
		if [[ "$file_hash" == $(md5sum  "$File") ]]; then
			echo "File integrity verified for $File"
			exit 0

		fi
		
 
	fi
done

echo "File integrity compromised or file not found"
