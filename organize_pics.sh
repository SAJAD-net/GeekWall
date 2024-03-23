#!/bin/bash

ltn=$(awk "/$1/{ print NR; exit }" README.md)
ltn=$(($ltn + 1))
for pic in `ls -tc $1`;do
	if [[ $pic =~ [0-9]+\_[0-9]+x[0-9]+\. ]];then
		last_pic=$(echo $pic | sed -r "s/_([0-9]*x[0-9]*).\w*//")
	else
		last_pic=0
	fi
	for npic in `ls -tc $1`;do
		if [[ ! $npic =~ [0-9]+\_[0-9]+x[0-9]+\. ]];then
			last_pic=$(($last_pic + 1))
			ext=${npic##*.}
			nname=${last_pic}_$1.$ext
			
			mv $1/$npic $1/$nname
			prel="![preview-$1-"$last_pic".$ext]($1/$nname?raw=true)"
			sed -i "${ltn}i $prel" README.md
		fi
	done
done
