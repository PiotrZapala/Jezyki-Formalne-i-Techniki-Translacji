#!/usr/bin/env python3

# Hello world!

bar = 0

# foo \
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
    # 23,
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
    # Print all:
    print(bar)
    print(baz)
    print(zxc)
    print(qwe)
    print(asd)
    print(poi)
    print(repr(foo.__doc__))
    print(jkl)
