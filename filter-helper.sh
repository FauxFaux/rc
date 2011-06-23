#!/bin/sh

function example() {
	MAPFILE=$(mktemp); echo $MAPFILE; git filter-branch -f --index-filter '. ~/bin/filter-helper.sh && processIndex "sed s/cat/horse/" '$MAPFILE
}

function exampleTwo() {
	MAPFILE=$(mktemp); echo $MAPFILE; git filter-branch -f --index-filter '. ~/bin/filter-helper.sh && processIndex '\''DIR=$(mktemp -d) && (cd $DIR && jar x && jar 0c .) && rm -rf $DIR'\'' '$MAPFILE' "*.jar"' -- --all
}

function resultant() {
	# $1: source blob
	# $2: mapping file
	# $3: processing function

	# blob is already a result
	if grep $1$ $2 > /dev/null; then
		printf $1

	# blob isn't present at all, process it
	elif ! grep $1 $2 > /dev/null; then
		OBLOB=$(git cat-file blob $1 | sh -c "$3" | git hash-object --stdin -w)
		echo $1 $OBLOB >> $2
		printf $OBLOB
	else # blob is on the left of the map
		awk '{if($1=="'$1'"){printf $2}}' < $2
	fi
}

function processIndex() {
	# $1: function
	# $2: mapping file
	# $3-: ls-files arguments
	FUNC=$1; shift
	MAP=$1; shift
	git ls-files -s "$@" | while IFS=$'\t' read DATA FILE; do
		SRC=$(echo $DATA | cut -d' ' -f2)
		DEST=$(resultant $SRC $MAP "$FUNC")
		printf "%s\t%s\n" "$(echo $DATA | sed s"/$SRC/$DEST/")" "$FILE"
	done | git update-index --index-info
}

