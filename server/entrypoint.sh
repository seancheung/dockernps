#!/bin/bash
set -e

conf_file='/etc/nps/conf/nps.conf'

IFS=$'\n' envs=($(awk 'BEGIN{for(v in ENVIRON) if (v ~ /^NPS_/) print v}'))
for i in "${envs[@]}"; do
    conf_key=$(echo "$i" | awk '{print substr(tolower($0), 5)}')
    conf_val="${!i}"
    sed -i "/^${conf_key}\s*=/s/=.*/=${conf_val}/" "$conf_file"
done

exec "$@"