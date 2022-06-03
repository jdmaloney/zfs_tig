#!/bin/bash

zfs_filesets=()

for f in ${zfs_filesets[@]}; do

while IFS= read -r line; do
	IFS=" " read -r username bytes_used bytes_quota obj_used obj_quota <<< "${line}"
	echo "zfs_quota,fs=${f},username=${username} bytes_used=${bytes_used},bytes_quota=${bytes_quota},obj_used=${obj_used},obj_quota=${obj_quota}"
done < <(/usr/sbin/zfs userspace -Hp ${f} | awk '{print $3" "$4" "$5" "$6" "$7}')

while IFS= read -r line; do
        IFS=" " read -r groupname bytes_used bytes_quota obj_used obj_quota <<< "${line}"
        echo "zfs_quota,fs=${f},groupname=${groupname} bytes_used=${bytes_used},bytes_quota=${bytes_quota},obj_used=${obj_used},obj_quota=${obj_quota}"
done < <(/usr/sbin/zfs groupspace -Hp ${f} | awk '{print $3" "$4" "$5" "$6" "$7}')

while IFS= read -r line; do
        IFS=" " read -r projectid bytes_used bytes_quota obj_used obj_quota <<< "${line}"
        echo "zfs_quota,fs=${f},projectid=${projectid} bytes_used=${bytes_used},bytes_quota=${bytes_quota},obj_used=${obj_used},obj_quota=${obj_quota}"
done < <(/usr/sbin/zfs projectspace -Hp ${f} | awk '{print $2" "$3" "$4" "$5" "$6}')

done

while IFS= read -r line; do
	IFS=" " read -r dataset bytes_used bytes_avail bytes_referenced mount_point <<< "${line}"
	echo "zfs_quota,fs=${dataset},mount_point=${mount_point} bytes_used=${bytes_used},bytes_avail=${bytes_avail},bytes_reference=${bytes_referenced}"
done < <(/usr/sbin/zfs list -Hp | awk '{print $1" "$2" "$3" "$4" "$5}')
