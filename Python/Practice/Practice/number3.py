# Intergrating a infinite loop to prompt user for int. If the user inputs a int the loop will break.

while True:
    try:
        x = int(input('What is x? '))
    except ValueError:
        print('x is not an int')
    else:
        break

print(f'x is {x}')