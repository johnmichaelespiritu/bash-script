#!/bin/bash

# Initialize variables
critical_threshold=""
warning_threshold=""
email_address=""

# A while loop to retrieve the value of the parameters regardless of their position.
while getopts "c:w:e:" option;
do
	case "$option" in
		c) critical_threshold="$OPTARG" ;;
		w) warning_threshold="$OPTARG" ;;
		e) email_address="$OPTARG" ;;
		*) echo "Invalid option: -$option" >&2
		   exit ;;
	esac
done

# Check for missing parameters
if [ -z "$critical_threshold" ] || [ -z "$warning_threshold" ] || [ -z "$email_address" ] 
then
	echo "Required parameters are missing: -c, -w, and -e. Please try again."
	exit
fi

# Check if the provided critical threshold is greater than the warning threshold
if [ "$critical_threshold" -le "$warning_threshold" ]
then
	echo "Critical threshold must be greater than the warning threshold. Please try again."
	exit
fi

# Calculate the memory usage
used_memory_percentage=$(free | grep Mem: | awk '{printf "%.0f", $3/$2 * 100}')

# Check whether the used memory percentage is greater than or equal to the critical threshold and the warning threshold, or if the memory is less than the warning threshold.
if [ "$used_memory_percentage" -ge "$critical_threshold" ]
then
	echo "Used memory is greater than or equal to critical threshold."	
	exit 2
elif [ "$used_memory_percentage" -ge "$warning_threshold" ]
then
	echo "Used memory is greater than or equal to warning threshold but less than critical threshold."
	exit 1
else
	echo "Used memory is less than warning threshold."
	exit 0
fi
