'''
dependencies for this project
'''

def populate(d):
    d.tools=['jsl','jsmin','closure']

def getdeps():
    return [
        __file__, # myself
    ]
