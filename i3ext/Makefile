all: xprintidle.so

xprintidle.so: xprintidle.c
	$(CC) -shared xprintidle.c -lX11 -lXss -lXext -fPIC -Wall -O2 -g -o xprintidle.so
