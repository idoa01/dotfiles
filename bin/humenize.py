#!/usr/bin/env python
import sys

if __name__ == '__main__':
    #if sys.stdin.isatty():
    #    input_data = sys.stdin.read().split()
    #else:
    #    input_data = sys.argv[1:]
    #input_lines = sys.stdin.read().split('\n')
    #print input_lines
    for line in sys.stdin.read().split('\n'):
        if len(line)==0:
            continue
        input_data = line.split()
        arg = int(input_data[0])
        units = 'K'
        if arg < 10:
            arg = arg + 0.0
            units = 'K'
        elif arg < 1000:
            arg = arg
            units = 'K'
        elif arg < 1000000:
            arg = arg / 1000.0
            units = 'M'

        print '%.2f%s\t%s' % (arg,units,' '.join(input_data[1:]))
