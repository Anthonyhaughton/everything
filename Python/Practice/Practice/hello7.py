# Defining main and calling main() at the bottom allows you to structure the code any
# way you want

def main():
    name = input("What's your name? ")
    hello(name)

    def hello(to="world"):
        print("hello,", to)


        main()