#!/bin/sh
set -e

if [ ! -d .git ]; then
	git init
	for f in "$@"; do
		git remote add -f $(basename $f) $f
	done
fi

for f in "$@"; do
	b=$(basename $f)
	git merge -s ours --no-commit $b/master
	git read-tree --prefix=$b -u $b/master
	git commit -m "Hack $b into our tree"
done

