#!/bin/bash
# Keep track of Linux OS logs

#validate script will work on Linux
if [[ $(uname) != Linux ]]; then
	echo "Warning - This script is designed to be run only on Linux but is showing as \"$uname\" . Exiting"
	exit 1
fi

echo Linux version detected: $(cat /etc/system-release) 

echo Message logs since last boot >> $output
#egrep -i "warning|critical|error|failed"  /var/log/messages | cut -c 17- | sort | uniq -c | sort -rn >> $output
echo Priority 1 Emergency >> $output
journalctl -b -p 1..1 | cut -c 16-| sort | uniq -c | sort -rn | head -10
echo Priority 2 Alert >> $output
journalctl -b -p 2..2 | cut -c 16-| sort | uniq -c | sort -rn | head -10
echo Priority 3 Critical >> $output
journalctl -b -p 3..3 | cut -c 16-| sort | uniq -c | sort -rn | head -10
echo Priority 4 Error >> $output
journalctl -b -p 4..4 | cut -c 16-| sort | uniq -c | sort -rn | head -10
echo Priority 5 Warning >> $output
journalctl -b -p 5..5 | cut -c 16-| sort | uniq -c | sort -rn | head -10
echo Search for errors
journalctl -b | egrep -i "warning|critical|error|failed" | cut -c 16- | sort | uniq -c | sort -rn | head -10
echo
