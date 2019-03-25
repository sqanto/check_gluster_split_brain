#!/bin/sh
# Check Split-Brain 
# Grep for numbers
# ADD all numbers together 
# If higher than one its a Critcal 
# Examle ./check_gluster_split_brain
# Sqanto
output=$(gluster volume heal $1 info split-brain  | grep "Number of entries in split-brain: "  | cut -c 35- | awk '{s+=$1} END {print s}')

if [ $output -eq 0 ]
then
    echo "OK - No Split-Brain on $i: $output"
    exit 0
elif [ $output -eq 1 ]
then
    echo "WARNING - Possible Split-Brain on $i: $output"
    exit 1
elif [ $output -gt 2 ]
then
    echo "CRITICAL - Split-Brain on $i: $output"
    exit 2
else
    echo "UNKNOWN - Something went wrong on $i: $output"
    exit 3
fi

