# Creating a function to print blocks like in mario
def main():
    print_column(3)


#def print_column(height):
#    for _ in range(height):
#        print("#")

# We can print the bricks in various ways. Whichever is fine.


def print_column(height):
    print("#\n" * height, end="")

main()