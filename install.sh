#!/bin/sh
set -e

for f in rc/.*; do 
	if [ -f "$f" ]; then
		[ -f $(basename "$f") ] && rm $(basename "$f")
		ln -s "$f"
	fi
done

