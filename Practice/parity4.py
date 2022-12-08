def main():
    x = int(input("What's x? "))
    if is_even(x):
        print("Even")
    else:
        print("Odd")

## Shorten line 10 to return the bool back. Either it does or does not have a remaider.
def is_even(n):
    return n % 2 == 0


main()