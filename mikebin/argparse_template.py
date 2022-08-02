#!/usr/bin/env python

import argparse
import sys

def check_positive(value):
    ivalue = int(value)
    if ivalue <= 0:
        raise argparse.ArgumentTypeError('%s is an invalid positive int value' % value)
    return ivalue

def parse_args():
    parser = argparse.ArgumentParser(description='App description',
                                     epilog='Some comment at end of help')
    parser.add_argument('positional', help='Positional arg')
    parser.add_argument('-i', '--intVal', type=int, default=0, help='Default int arg')
    parser.add_argument('-l', '--longString', type=str, default='loooong', help='defautl string arg')
    parser.add_argument('-r', '--required', type=str, required=True, help='Required arg')
    parser.add_argument('--moreThanOne', type=str, nargs='+', help='one or MORE required')
    parser.add_argument('--maybeSome', type=str, nargs='*', help='zero or MORE required')
    parser.add_argument('--wantTrue', action='store_true',  help='True if set boolean')
    parser.add_argument('--wantFalse', action='store_false',  help='False if set boolean')
    parser.add_argument('--positive', type=check_positive,  help='Only allow positive values')
    parser.add_argument('--choices', type=int, choices=range(5,10), help='within range')

    return parser.parse_args()

    ## Return as a map instead of args object.
    #return vars(parser.parse_args())

def main():
    args = parse_args()

if __name__ == '__main__':
    main()
