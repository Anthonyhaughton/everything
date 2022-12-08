## Using "While True" to induce an infinite loop.
## Then once the number is met we can use "Break"
## and it breaks out the While loop

while True:
    n = int(input("What's n? "))
    if n > 0:
        break

for _ in range(n):
    print("meow")