# ZFS TIG
Telegraf Checks and Grafana Dashboards for Monitoring ZFS with TIG

## ZFS Quota Data
This check ingests user, group, and project quota data for specified ZFS datasets for injection into InfluxDB.  This script can be called at any desired interval; recommended default is 15 minutes.

## ZFS Dataset Stats
This check ingests properties about each ZFS dataset on the host so utilization numbers and compression ratios can be tracked over time.  
