def main():
    x = get_int('What is x? ')
    print(f'x is {x}')

# To clean up the code we can actually just return the int in place of the x =
# we can also use pass to promt the use to enter x until they put in a int (line 13)

# We can remove the 'What is x?' in the func get_int so that our main can promt for xyz whatever and all our
# func will do is get the number and or str

def get_int(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            pass

main()