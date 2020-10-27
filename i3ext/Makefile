all: xprintidle.so

# s apt install libxss-dev libxext-dev
xprintidle.so: xprintidle.c
	$(CC) -shared xprintidle.c \
		-lX11 -lXss -lXext \
		-fPIC -Wall -Wextra -pedantic -O1 -D_FORTIFY_SOURCE=2 -fstack-protector \
		-g -o xprintidle.so
