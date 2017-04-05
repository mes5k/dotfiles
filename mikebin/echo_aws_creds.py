#!/usr/bin/env python

import sys
import argparse
from ConfigParser import SafeConfigParser

def parse_cmdline():
    desc = 'Print AWS env variables'
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('section', help='The section to export variables for')
    args = parser.parse_args()
    return args

def main():
    args = parse_cmdline()
    parser = SafeConfigParser()
    parser.read('/Users/msmoot/.aws/credentials')

    print( "unset AWS_REGION" )
    print( "unset AWS_ACCESS_KEY_ID" )
    print( "unset AWS_SECRET_ACCESS_KEY" )
    print( "unset AWS_SESSION_TOKEN" )

    printOption(parser, args.section, 'AWS_REGION',            'region')
    printOption(parser, args.section, 'AWS_ACCESS_KEY_ID',     'aws_access_key_id')
    printOption(parser, args.section, 'AWS_SECRET_ACCESS_KEY', 'aws_secret_access_key')
    printOption(parser, args.section, 'AWS_SESSION_TOKEN',     'aws_session_token')

def printOption(parser, section, env, key):
    if parser.has_option(section, key):
        print( "export %s=%s" % (env, parser.get(section,key) ) )

if __name__ == '__main__':
    main()
