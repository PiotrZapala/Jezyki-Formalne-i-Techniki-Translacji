



bar = 0


bar = 17

baz = f'He # llo!'

zxc = """
# :)
"""

qwe = "\
# :(\
"

asd = (
    17,
    
    34
)

poi = repr("""
    Is this fine?
""")

jkl = 0

def foo():
    '''
    this is a docstring
    '''
    global jkl
    jkl = 15
    return 7

"""
{:x}
""".format(foo())

if True:
    
    print(bar)
    print(baz)
    print(zxc)
    print(qwe)
    print(asd)
    print(poi)
    print(repr(foo.__doc__))
    print(jkl)
