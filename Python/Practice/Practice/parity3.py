def main():
    x = int(input("What's x? "))
    if is_even(x):
        print("Even")
    else:
        print("Odd")

## Shorten the If Elif statements to one line to clean up code "Pythonic"
def is_even(n):
    return True if n % 2 == 0 else False


main()