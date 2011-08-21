#!/bin/sh

function example() {
	MAPFILE=$(mktemp); echo $MAPFILE; git filter-branch -f --index-filter '. ~/bin/filter-helper.sh && processIndex "sed s/cat/horse/" '$MAPFILE
}

function exampleTwo() {
	MAPFILE=$(mktemp); echo $MAPFILE; git filter-branch -f --index-filter '. ~/bin/filter-helper.sh && processIndex '\''DIR=$(mktemp -d) && (cd $DIR && jar x && jar 0c .) && rm -rf $DIR'\'' '$MAPFILE' "*.jar"' -- --all
}

function exampleThree() {
	MAP=$(mktemp -d); git filter-branch -f --index-filter '. ~/bin/filter-helper.sh && processIndex "sed s/pony/horse/" '$MAP -- --all
}

# maintains a map inside mapping folder,
# i.e. f(X) == Y, f(Y) == Y
function resultant() {
	# $1: source blob
	# $2: mapping folder
	# $3: processing function

	if [ -f $2/$1 ] ; then
		cat $2/$1

	# blob isn't present
	else
		OBLOB=$(git cat-file blob $1 | sh -c "$3" | git hash-object --stdin -w)
		printf $OBLOB > $2/$1
		printf $OBLOB > $OBLOB
		printf $OBLOB
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

