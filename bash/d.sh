#!/bin/bash
# src dir.
SRC_DIR=$1

# dest dir.
DEST_DIR=$2
f=''
df=''
find $1 -type f | while read sf; 
do 
	f="${sf#$1}"
	df="$2$f"
	diff "$sf" "$df">/dev/null 2>/dev/null
	if [ "$?" != 0 ]; then
		echo "diff found: $sf"
#		cp $sf $df>/dev/null 2>/dev/null
#		if [ "$?" != 0 ]; then
#			mkdir -p $(dirname $df)  #${df%/*}
#			cp $sf $df
#		fi
	fi
done

echo $sf $df


