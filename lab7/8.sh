#!/bin/bash

#example ./8


location=/Users/macriidanu/Desktop/soLab/lab7


for file in "$location"/*; do
	if [[ "$file" == *.log ]];then
		if  find "$file" -mtime -7 | grep -q . ;then
      printf "Confirm deletion of outdated file ? \n$file \nY/n \n"
      read confirmation
      if [[ "$confirmation" == "Y" ]];then
        rm "$file"
        echo "File deleted."
        echo $(date -u) "File deleted $file" >> cleanup.log
      else
        echo "File is not deleted"
      fi
		fi
	fi
done
