## Using Elif to clean up code so that we don't have to keep asking
## if questions

x = int(input("What is x? "))
y = int(input("What is y? "))

if x < y:
    print("x is less than y")

elif x > y:
    print("x is greater than y")

elif x == y:
    print("x is equal to y")