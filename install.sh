#!/bin/sh
set -e

for f in rc/.*; do 
	if [ -f "$f" ]; then
		rm $(basename "$f")
		ln -s "$f"
	fi
done

