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
		   exit 1 ;;
	esac
done

# Check for missing parameters
if [ -z "$critical_threshold" ] || [ -z "$warning_threshold" ] || [ -z "$email_address" ] 
then
	  echo "Required parameters are missing: -c, -w, and -e"
	  exit
fi
