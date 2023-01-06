MENU = {
    "espresso": {
        "ingredients": {
            "water": 50,
            "coffee": 18,
        },
        "cost": 1.5,
    },
    "latte": {
        "ingredients": {
            "water": 200,
            "milk": 150,
            "coffee": 24,
        },
        "cost": 2.5,
    },
    "cappuccino": {
        "ingredients": {
            "water": 250,
            "milk": 100,
            "coffee": 24,
        },
        "cost": 3.0,
    }
}

resources = {
    "water": 300,
    "milk": 200,
    "coffee": 100,
}

coins = {
    "quarter": .25,
    "dime": .10,
    "nickle": .5,
    "penny": .1
    
}

profit = 0

def is_sufficient(order_ingredients):
    for item in order_ingredients:
        if order_ingredients[item] > resources[item]:
            print(f'Sorry there is not enough {item}.')
            return False
        else:
            return True

def process_coins():
    total = int(input('How many Quarters?: '))
    total =+ int(input('How many Dimes?: '))
    total =+ int(input('How many Nickles?: '))
    total =+ int(input('How many Pennies?: '))
    return total

def is_successful(money_recieved, drink_cost):
    if money_recieved >= drink_cost:
        change = round(money_recieved - drink_cost, 2)
        print(f'Here is your change: ${change}')
        global profit
        profit += drink_cost
        return True
    else:
        print("Sorry that's not enough money. Money refunded.")
        return False
        
def make_coffee(drink_name, order_ingredients):
    for item in order_ingredients:
        resources[item] -= order_ingredients[item]
    print(f'Here is your {drink_name}.')
        

while True:
    choice = input("What would you like? (espresso/latte/cappuccino): ")
    if choice == 'off':
        break
    elif choice == 'report':
        print(f'Water: {resources["water"]}ml')
        print(f'Milk: {resources["milk"]}ml')
        print(f'Coffee: {resources["coffee"]}g')
        print(f'Money: ${profit}')
    else:
        drink = MENU[choice]
        if is_sufficient(drink['ingredients']):
            payment = process_coins()
            if is_successful(payment, drink['cost']):
                make_coffee(choice, drink['ingredients'])
            
            
            
        
        
    
        
        