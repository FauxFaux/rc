all: xprintidle.so

# s apt install libxss-dev libxext-dev
xprintidle.so: xprintidle.c
	$(CC) -shared xprintidle.c -lX11 -lXss -lXext -fPIC -Wall -Wextra -pedantic -O2 -g -o xprintidle.so
