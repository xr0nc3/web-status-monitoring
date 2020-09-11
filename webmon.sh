#!/bin/bash
KEY=""
ID="="
TIMEOUT="100"
URL="https://api.telegram.org/bot$KEY/sendMessage?chat_id=$ID"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
#TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'
curl=/usr/bin/curl

hosts=""                                                                                                                                                                                                                                                                                                                                                                                       

for host in $hosts; do
    http_status=$($curl  curl -sI --get https://$host | head -n1 | awk '{print $2}' )
    if [[ "$http_status" -ne "200"]]; then
        #echo "Host $host returned status '$http_status  '"
        TEXT="#RWS $DATE_EXEC: Domain $host status code $http_status"
        curl -s --max-time $TIMEOUT -d "chat_id=@u5mbot&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
        #rm $TMPFILE
    fi
    #echo "$host status up"
done;

