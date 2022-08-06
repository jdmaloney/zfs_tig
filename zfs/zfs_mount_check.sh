#!/bin/bash

## Check the list
datasets_to_check=()
check_file=""

for d in ${datasets_to_check[@]}
do
        check=$(grep ${d} /proc/mounts | grep zfs)
                if [ -n "$check" ]; then
			#It's in /proc/mounts
                	proc_check=0
		else
			proc_check=1
		fi
	stat=$(/usr/bin/stat ${d}/${check_file})
	if [ -n "$stat" ]; then
		#We can stat a file
		stat_check=0
	else
		stat_check=1
	fi
	if [ $proc_check -eq 0 ] && [ $stat_check -eq 0 ]; then
		#All is healthy
		echo "mountcheck,fs=${d} presence=1"
	else
		echo "mountcheck,fs=${d} presence=0"
	fi

done
