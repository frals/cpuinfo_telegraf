#!/bin/bash
PATH=/bin:/usr/bin:/usr/sbin
FREQ=`cat /proc/cpuinfo |grep 'cpu MHz' | awk '{print $4}' | tr "\n" "\n"`
HOST=`uname -n`

print_influx_line() {
    echo "cpuinfo,host=${HOST} $1=$2"
}

CORE=0
while IFS='\n' read -ra FQS; do
     for i in "${FQS[@]}"; do
         print_influx_line "core${CORE}" $i
         ((CORE++))
     done
done <<< "$FREQ"
