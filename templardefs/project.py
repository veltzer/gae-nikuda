'''
project definitions for templar
'''

def to_php(x):
	if type(x)==str:
		return '\'{0}\''.format(x)
	if type(x)==bool:
		if x:
			return 'TRUE'
		else:
			return 'FALSE'
	if x is None:
		return 'null'
	raise ValueError('dont know how to translate type', type(x), x)

def populate(d):
	d.project_name='nikuda'
	d.project_long_description='Nikuda web site'
	d.project_year_started='2004'
	d.project_description='''Nikuda is a web site intended to allow
users to get punctuation for hebrew words, sentences and paragraphs.'''

	d.to_php=to_php

def getdeps():
	return [
		__file__, # myself
	]
