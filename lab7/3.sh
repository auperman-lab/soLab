#!/bin/bash

# example


RED='\033[0;31m'
percentage=$(df -h | awk '{if ($5+0>80) print $1, $5}')


if [ -z "$percentage" ]; then
    echo "No filesystem has usage greater than 80%"
else
	echo " Warning: Partition $percentage is above 80% "
	echo $(date -u) "Warning: Partition $percentage is above 80%  \n" >>disk_usage.log
fi
