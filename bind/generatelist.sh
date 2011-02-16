#!/bin/bash
# Yeri Tiete
#	aka Tuinslak
# http://yeri.be

FILE=example.log
TMPFILE=/tmp/_urlextractor
OUTPUT=list.txt
i=0

echo "	> Starting URL generator at `date -u +%H:%M:%S`."
# delete old file if existing
echo "	>> Cleaning up $OUTPUT."
[ -e $OUTPUT ] && rm $OUTPUT

echo "	>> generating $TMPFILE."
# This is what I do in the next command;
#	get 6th column,		
#	tolower()		
#	get unique   
#	remove '<', '>', '=', '#'	
#	remove arpa requests	
#	remove random namebench queries		
#	remove more namebench crap
awk '{print $6 }' $FILE | awk '{print tolower($0)}' | awk '!x[$0]++' | sed '/[=#<>]/d' | awk '{print tolower($0)}' | grep -Ev 'in-addr.arpa' | grep -Ev 'ip6.arpa' | grep -Ev 'namebench' | egrep -Ev '[a-z0-9]{26}' | sort > $TMPFILE

# Start wget check
echo "	>> Starting HTTP checker at `date -u +%H:%M:%S`."
echo "	>>> Please be patient."

# Might take a looooong time -- threading could come in handy here
while read a; do {
	let i++
	echo "	>>> ($i) $a at `date -u +%H:%M:%S`."
	[[ `wget $a --timeout=3 --tries=1 --user-agent="URL-Extractor (http://yeri.be/ij)" --no-check-certificate -O /dev/null 2>&1 | grep "200 OK"` != "" ]] && echo $a >> $OUTPUT && echo "	>>>> 	ok" || echo "	>>>> 	nok"
} done < $TMPFILE

# done
echo "	>>> Done, $i URLs checked."
echo "	>> $OUTPUT generated."
echo "	> End of program."

# bye!