#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import json
import io
import time

from idle import idle_ms

def now():
    return int(round(time.time() * 1000))

last_break = now()

def break_msg():
    global last_break
    if idle_ms() > 60*1000:
        last_break = now()
    remaining = last_break + (10 * 60 * 1000) - now()
    minutes = round(remaining / 60 / 1000)
    return {'full_text' : str(minutes) + 'm', 'name' : 'break', 'color': '#ffffff' if minutes > 0 else '#ff0000' }

stdin = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
       sys.exit()

def main():
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''

        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)

        j.insert(0, break_msg())

        print_line(prefix+json.dumps(j))

if __name__ == '__main__':
    main()

