#!/bin/bash

tfile=$(mktemp /tmp/zpool.XXXXXX)
pools=($(/usr/sbin/zpool list | grep -v NAME | awk '{print $1}'))

for p in ${pools[@]}
do
	/usr/sbin/zpool status ${p} -p | sed '1,/NAME/d' | sed -n '/errors/q;p' | sed '/^[[:space:]]*$/d' | awk '{print $1" "$2" "$3" "$4" "$5}' > "${tfile}"
	vdev_type=pool
	while read l; do
		IFS=" " read -r zname state readerr writeerr chksmerr <<< "${l}"
		case ${zname} in
			${p})
				echo "zfshealth,pool=${p},device=${zname},type=pool,vdev_type=none,state=${state} readerr=$readerr,writeerr=${writeerr},checksum=${chksmerr}";;
			raidz*|mirror*|draid*)
				echo "zfshealth,pool=${p},device=${zname},type=vdev,vdev_type=${vdev_type},state=${state} readerr=$readerr,writeerr=${writeerr},checksum=${chksmerr}";;
			special|logs|cache)
				vdev_type=${zname};;
			*)
				echo "zfshealth,pool=${p},device=${zname},type=drive,vdev_type=${vdev_type},state=${state} readerr=$readerr,writeerr=${writeerr},checksum=${chksmerr}"
		esac
	done < "${tfile}"
done
rm -rf ${tfile}
