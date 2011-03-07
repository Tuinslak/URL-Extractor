#!/bin/bash
# Yeri Tiete
#	aka Tuinslak
# http://yeri.be

FILE=top-1m.csv
OUTPUT=list.txt

awk '{print $2}' FS="," $FILE > $OUTPUT
