# Making a function 'get_int'

def main():
    x = get_int()
    print(f'x is {x}')

# I can remove break on line 16 and replace it with return bc return can do both

def get_int():
    while True:
        try:
            x = int(input('What is x? '))
        except ValueError:
            print('x is not an int')
        else:
            return x

main()