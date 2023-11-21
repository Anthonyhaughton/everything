# Here we are going to try to move the print to the bottom of the code.
# But without 'else' this fails because x never gets a value in line 6 if
# a non int is entered.

try:
    x = int(input('What is x? '))
except ValueError:
    print('x is not an int')
else:
    print(f'x is {x}')