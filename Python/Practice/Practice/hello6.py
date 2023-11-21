# Saying Hello using defs "Define"
# Setting paramater to "to". Setting Default value ="world" in the case that nothing
# is entered.

def hello(to="world"):
    print("hello,", to)

#hello() <- pointing to the default param we set in line 5 "world"

name = input("What's your name? ")
hello(name)
