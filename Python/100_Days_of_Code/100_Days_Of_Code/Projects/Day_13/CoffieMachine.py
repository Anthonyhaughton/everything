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

# TODO: 4.5 Check resource sufficent?
def is_resource_sufficient(order_ingredients):
    ''' Returns True when order can be made, False when ingredients are insufficient. '''
    for item in order_ingredients:
        if order_ingredients[item] > resources[item]:
            print(f'Sorry there is not enough {item}.')
            return False
    return True
    
# TODO: 5.5 Process Coins
def process_coins():
    ''' This will take in the users coins and add them all together and return the total amount. '''
    print('Please insert coins. ')
    total = int(input('How many quaters?: ')) * 0.25
    total += int(input('How many dimes?: ')) * 0.1
    total += int(input('How many nickles?: ')) * 0.05
    total += int(input('How many pennies?: ')) * 0.01
    return total

# TODO: 6.5 Check transaction successful?
def is_transaction_sucessful(money_recieved, drink_cost):
    ''' Return True when payment is accepted, or False if money is insufficient. '''
    if money_recieved >= drink_cost:
        change = round(money_recieved - drink_cost, 2)
        print(f'Here is ${change} in change.')
        global profit
        profit += drink_cost
        return True
    else:
        print("Sorry that's not enough money. Money refunded.")
        return False

# TODO 7.5 Make Coffee
def make_coffee(drink_name, order_ingredients):
    ''' Deduct the required ingredients from the resources. '''
    for item in order_ingredients:
        resources[item] -= order_ingredients[item]
    print(f'Here is your {drink_name} ☕')

# TODO 8. Put the final code inside a func.
def coffee_maker():
    while True:
        # TODO: 1 Prompt user by asking “ What would you like? (espresso/latte/cappuccino): ”
        choice = input('What would you like? (espresso/latte/cappuccino): ')

        # TODO: 2. Turn off the Coffee Machine by entering “ off ” to the prompt.
        if choice == 'off':
            break
        
        # TODO: 3. Print report.
        elif choice == 'report':
            print(f"Water: {resources['water']}ml")
            print(f"Milk: {resources['milk']}ml")
            print(f"Coffee: {resources['coffee']}g")
            print(f"Money: ${profit}")
        
        # TODO: 4. Check resource sufficent?
        else:
            drink = MENU[choice]
            if is_resource_sufficient(drink['ingredients']):
                # TODO: 5. Process Coins
                payment = process_coins()
                # TODO: 6. Check transaction successful?
                if is_transaction_sucessful(payment, drink['cost']):
                    # TODO 7 Make Coffee
                    make_coffee(choice, drink['ingredients'])
 
# Call program   
coffee_maker()