# Functions with Inputs
def greet():
    print('hi')
    print('hi')
    print('hi')

greet()

# In the func below, (name) is the "parameter" and when we call it 'Anthony' is the "argument"

def greet_with_name(name):
    print(f'hi {name}')
    print(f'how are you {name}')
    print(f'Whats up {name}')
greet_with_name('Anthony')

# Func with more than 1 input
def greet_with(name, location):
    print(f'hi {name} welcome to {location}')
    print(f'how are you {name} when did you come to {location}')
    print(f'Whats up {name} fancy seeing you in {location}')
greet_with('Anthony', 'Arlington')

# Key word arguments
def my_func(a, b, c):
    #Do this with a
    # Then do this with b
    # Finally do this with c
my_func(a=1, b=2, c=3)
