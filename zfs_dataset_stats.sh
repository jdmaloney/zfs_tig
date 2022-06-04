#!/bin/bash

zfs_datasets=($(/usr/sbin/zfs list -H | awk '{print $1}' | xargs))

for d in ${zfs_datasets[@]}
do
stat_line=""
	while IFS= read -r line; do
		IFS=" " read -r property value <<< "${line}"
		stat_line="${stat_line},${property}=${value}"
	done < <(/usr/sbin/zfs get all ${d} -p | awk '$2 == "compressratio" || $2 == "referenced" || $2 == "written" || $2 == "logicalused" || $2 == "logicalreferenced" || $2 == "used" || $2 == "refcompressratio" || $2 == "usedbysnapshots" || $2 == "usedbysnapshots" || $2 == "available" {print $2" "$3}')
	real_stat_line=$(echo ${stat_line} | cut -c 2-)
	echo "zfs_stats,dataset=${d} ${real_stat_line}"
done
