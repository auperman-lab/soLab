
#!/bin/bash

#example ./1.sh Laborator.docx /Users/macriidanu/Desktop/soLab


check_file_permission(){
	local file=$1
	local perm=$2
	permission=$(stat -f "%p" "$file")
	permission=${permission:3}

	if [ "$permission" -gt "$perm" ] ; then
        
        	echo "The file has insecure permissions"
        	chmod perm "$file"
		echo "File permissions changed"
	else
        	echo "The file has secure permissions"
	fi
}

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

check_file_permission "$file" 644



for File in "$dir"/*; do
	if [[ "$File" == *.sh ]];then
		if [[ -x "$File" ]];then
			echo "The script $File is executable."
		else
			echo "The script $File is not executable."
			chmod +x "$File"
			echo "Changed the script to be executable"
		fi
	fi 
done


