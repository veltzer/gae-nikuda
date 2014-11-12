'''
project definitions for templar
'''

def populate(d):
	d.project_name='nikuda'
	d.project_long_description='Nikuda web site'
	d.project_year_started='2004'
	d.project_description='''Nikuda is a web site intended to allow
users to get punctuation for hebrew words, sentences and paragraphs.'''

def getdeps():
	return [
		__file__, # myself
	]
