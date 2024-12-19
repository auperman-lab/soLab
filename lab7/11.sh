#!/bin/bash

#example ./11.sh

ports=$(netstat -anvp tcp | awk 'NR<3 || /LISTEN/'| awk '{print $4}')
echo "$ports"
echo $(date -u) "$ports" >> "./open_ports.log"
