#!/bin/bash
# Yeri Tiete
# add www. to all lines

LIST=list.txt
TMP=/tmp/_add-www
OUTPUT=www.list.txt

# delete old files
[ -e $TMP ] && rm $TMP

while read a; do {
	echo www.$a >> $TMP
} done < $LIST

# optional
# remove urls with a slash (youtube.com/user/tuinslak e.g.), we most likely already check the root
sed '/[/]/d' $TMP > $OUTPUT

# if you comment line above, uncomment this
#mv $TMP $OUTPUT
