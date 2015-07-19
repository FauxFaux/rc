#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import ctypes
from os.path import expanduser

xp = ctypes.cdll.LoadLibrary(expanduser('~/rc/i3ext/xprintidle.so'))

def idle_ms():
    ret = xp.get()
    if ret < 0:
        raise Exception('call failed: ' + str(ret))
    return ret

if __name__ == '__main__':
    print(idle_ms())

