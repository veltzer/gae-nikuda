#!/usr/bin/python3

'''
this is a specific wrapper written for the css validator

css validator does NOT return a good error code (0 always).
'''

import sys # for argv
import subprocess # for Popen, PIPE

# run the command
pr=subprocess.Popen(sys.argv[1:], stdout=subprocess.PIPE, shell=False)
doPrint=False
error=False
for line in pr.stdout:
	line=line.decode()
	if line.startswith('Sorry'):
		doPrint=True
		error=True
	if line.startswith('Valid'):
		doPrint=False
	if doPrint:
		print(line, end='')
if error:
	sys.exit(1)
