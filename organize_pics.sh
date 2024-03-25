#!/bin/bash

dpt=$(echo $1 | grep -Eo '\w*')
ltn=$(awk "/$dpt/{ print NR; exit }" README.md)
ltn=$(($ltn + 1))

last_pic=$(sed "${ltn}q;d" README.md | grep -Eo '[0-9]*_' | sed -r "s/_//")

if [ ! $last_pic ]
then
	last_pic=0
fi

for npic in `ls -ut $1`
do
	if [[ ! $npic =~ [0-9]+\_$dpt\. ]];then
		last_pic=$(($last_pic + 1))
		ext=${npic##*.}
		nname=${last_pic}_$dpt.$ext
		
		mv $dpt/$npic $dpt/$nname
		prel="![preview-$dpt-"$last_pic".$ext]($dpt/$nname?raw=true)"
		sed -i "${ltn}i $prel" README.md
	fi
done
