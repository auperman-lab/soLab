#!/bin/bash

#./6.sh Users/macriidanu/Desktop/soLab/lab6


dir=$1
location=/Users/macriidanu/Desktop/soLab/lab7


if [ -z "$dir" ] || [ ! -d "$dir" ]; then
	echo "Usage: $0 <directory>"
	exit 1
fi

timestamp=$(date -u +"%Y-%m-%d_%H-%M-%S")


tar -cvzf "$location/$timestamp".tar.gz "$dir"

