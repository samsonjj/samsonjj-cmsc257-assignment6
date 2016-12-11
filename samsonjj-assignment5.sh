#!/usr/bin/env bash
reD="\b[dD](.*[dD]){0,1}\b"
reA="\b[Aa](.*[[:alpha:]]\b|\b)"
reN="\b[0-9]+\b"
reALNUM="([[:alpha:]].*[[:digit:]]|[[:digit:]].*[[:alpha:]])"

count=0
lineCount=0
wordCount=0
mostRepCount=0
dCount=0
aCount=0
numCount=0
alnumCount=0

repWord=hello
leastWord=hello

filename=${1}
while read -r line
do
   	lineCount=$((lineCount+1))
	words=${line}
   	for word in $words
   	do 
		#d count
		if [[ $word =~ $reD ]]; then
			dCount=$((dCount+1))
		fi
		#a count
		if [[ $word =~ $reA ]]; then
                        aCount=$((aCount+1))
                fi
		#num count
		if [[ $word =~ $reN ]]; then
                        numCount=$((numCount+1))
                fi

		#alnum count
                if [[ $word =~ $reALNUM ]]; then
                        alnumCount=$((alnumCount+1))
                fi

		#word count
		wordCount=$((wordCount+1))

   	done 
done < ${filename}

repWord="$(tr ' \t\f' '[\n*]' < sample.txt | sort | grep -v '^$' | uniq -c | sort -nr | head -1 | grep -o '[0-9]\+\s[[:alnum:]]\+' | grep -o '\s[[:alnum:]]\+')"

leastWord="$(tr ' \t\f' '[\n*]' < sample.txt | sort | grep -v '^$' | uniq -c | sort -n | head -1 | grep -o '[0-9]\+\s[[:alnum:]]\+' | grep -o '\s[[:alnum:]]\+')"

echo "matching count: $count"
echo "line count: $lineCount"
echo "word count: $wordCount"
echo "most repetitive word:$repWord"
echo "least repetitive word:$leastWord"
echo "d count: $dCount"
echo "a count: $aCount"
echo "number count: $numCount"
echo "alpha numeric count: $alnumCount"
