#!/bin/bash

#example

echo $(ps aux | sort -nrk 3,3 | head -n 5)
echo $(date -u) $(ps aux | sort -nrk 3,3 | head -n 5) >> process_log.txt

