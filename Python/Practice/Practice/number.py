# Here we will try to predict user error using "try" and "except"
# try - is going to try the lines of code indented
# except - is going to kick in when the user inserts something they aren't supposed to ie a str in int
# note: you can also just do except: with no Error but that is lazy

try:
    x = int(input('What is x? '))
    print(f'x is {x}')
except ValueError:
    print('x is not an int')