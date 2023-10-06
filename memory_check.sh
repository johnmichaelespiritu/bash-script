#!/bin/bash

# Initialize variables
critical_threshold=""
warning_threshold=""
email_address=""

# A while loop to get the value of the parameters
while getopts "c:w:e:" option;
do
	case "$option" in
		c) critical_threshold="$OPTARG" ;;
		w) warning_threshold="$OPTARG" ;;
		e) email_address="$OPTARG" ;;
		*) echo "Invalid option: -$option" >&2
		   exit 1 ;;
	esac
done

echo $critical_threshold
echo $warning_threshold
echo $email_address

