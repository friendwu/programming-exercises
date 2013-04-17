#!/bin/bash
SRC_DIR="$1" 
shift
DEST_DIR="$@"

echo $SRC_DIR $DEST_DIR
f=''
df=''
find $SRC_DIR -type f | while read sf; 
do 
	f="${sf#$SRC_DIR}"
	df="$DEST_DIR$f"
	cmp -s "$sf" "$df"  #>/dev/null 2>/dev/null
	if [ "$?" != 0 ]; then
		echo "diff found: $sf"
	#	cp "$sf" "$df" >/dev/null 2>/dev/null
	#	if [ "$?" != 0 ]; then
	#		mkdir -p "$(dirname "$df")"  #${df%/*}
	#		cp "$sf" "$df"
	#	fi
		echo "cp $sf $df"
	fi
done



