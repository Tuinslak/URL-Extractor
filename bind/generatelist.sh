#!/bin/bash
# Yeri Tiete 
#	aka Tuinslak
# http://yeri.be

FILE=example.log
TMPFILE=/tmp/_urlextractor
OUTPUT=list.txt

# delete old file if existing
[ -e $OUTPUT ] && rm $OUTPUT

# get 6th column,		get unique	remove arpa requests
awk '{print $6 }' $FILE | awk '!x[$0]++' | awk '{print tolower($0)}' | grep -Ev 'in-addr.arpa' > $TMPFILE

while read a; do {
	[[ `wget $a --tries=1 --user-agent="URL-Extractor (http://yeri.be/ij)" --no-check-certificate -O /dev/null 2>&1 | grep "200 OK"` != "" ]] && echo $a >> $OUTPUT
} done < $TMPFILE
