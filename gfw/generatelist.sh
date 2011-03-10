#!/bin/bash
# Generate an unique list from gfw files
F1=../../gfw-url-checker/testResults/nl/alexa10032011_nok.csv 
F2=../../gfw-url-checker/testResults/cn/alexa08032011_nok.csv
TMP=/tmp/_gfw

# merge files
cat $F1 > $TMP
cat $F2 > $TMP

# get uniques, make list
awk '{print $1}' FS="," $TMP | awk '!x[$0]++' > list.txt
