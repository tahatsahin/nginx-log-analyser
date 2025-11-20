#!/bin/bash

# log type: IP - - [date:time tmz] "method /path protocol" rescode bytesSent referrer userAgent
#
# 143.110.222.166 - - [04/Oct/2024:03:01:52 +0000] "GET / HTTP/1.1" 200 409 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Mobile/15E148 Safari/604.1"
# 143.110.222.166 - - [04/Oct/2024:03:02:03 +0000] "GET / HTTP/1.1" 200 409 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Mobile/15E148 Safari/604.1"
# 159.89.185.30 - - [04/Oct/2024:03:02:04 +0000] "GET /v1-health HTTP/1.1" 200 51 "-" "DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com)"

# take file as arg
file="$1"

echo "Top 5 IP addresses with the most requests:"
# get ip addresses using awk using seperator ' ', count using uniq, sort numerical and reverse, get top 5
cat $file | awk '{ print $1 }' | sort | uniq -c | sort -k1 -nr | head -n 5 | awk '{ printf "%s\t-\t%s\trequests\n", $2, $1 }'
echo
echo "Top 5 most requested paths:"
# get paths using awk using seperator '"', count using uniq, sort numerical and reverse, get top 5
# IDK why do i need the sort->uniq->sort again... 1 sort somehow doesn't work...
cat $file | awk -F'"' '{ print $2 }' | awk '{ print $2 }' | sort | uniq -c | sort -k1 -nr | head -n 5 | awk '{ printf "%s\t-\t%s\trequests\n", $2, $1 }'
echo
echo "Top 5 response status codes:"
# get paths using awk using seperator ' ', count using uniq, sort numerical and reverse, get top 5
cat $file | awk '{ print $9 }' | sort | uniq -c | sort -k1 -nr | head -n 5 | awk '{ printf "%s\t-\t%s\trequests\n", $2, $1 }'

