# ZFS TIG
Telegraf Checks and Grafana Dashboards for Monitoring ZFS with TIG

Note: These checks are in supplement to the community maintained [[inputs.zfs]] plugin

## ZFS Quota Data
This check ingests user, group, and project quota data for specified ZFS datasets for injection into InfluxDB.  This script can be called at any desired interval; recommended default is 15 minutes.

## ZFS Dataset Stats
This check ingests properties about each ZFS dataset on the host so utilization numbers and compression ratios can be tracked over time.  

## zpool Health
This check ingests data about each pool in terms of its health; it parses through `zpool status` output and records all the values reported for each device and tags by pool, device type, and vdev type.  

## ZFS Mount Check
Verifies all specified pools and/or datasets are mounted on the machine.  The check_file is a file (usually a hidden file) that should be present in all pools/datasets.  Part of the mount check verifies that file can be seen by a `stat` command.
