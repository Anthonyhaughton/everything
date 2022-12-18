# https://www.youtube.com/watch?v=th4OBktqK1I

import random

# Creating global vars to refer to 
MAX_LINES = 3
MAX_BET = 100
MIN_BET = 1

ROWS = 3
COLS = 3

# Creat a dict of all the symbols and how freq they appear
symbol_count = {
    'A': 4,
    'B': 6,
    'C': 8,
    'D': 10
}

# A dict to determine the value of the win
symbol_value = {
    'A': 12,
    'B': 9,
    'C': 6,
    'D': 3
}

def check_winnings(columns, lines, bet, values):
    winnings = 0 
    winning_lines = []
    for line in range(lines):
        # Checking that every symbol is the same in a line 
        symbol = columns[0][line]
        for column in columns:
            symbol_to_check = column[line]
            if symbol != symbol_to_check:
                break
        else:
            winnings += values[symbol] * bet
            winning_lines.append(line + 1)
            
    return winnings, winning_lines
                
def get_slot_machine_spin(rows, cols, symbols):
    # Make an empty list
    all_symbols = []
    # Iterite through the dict to get every variation of the 4 symbols. using .items() will give you the key and the value for the dict
    for symbol, symbol_count in symbols.items():
        # Once you have the symbols we append to the symbols list so A goes in twice etc
        for _ in range(symbol_count):
            all_symbols.append(symbol)
    
    # Def empty coloumn list
    columns = []
    # Generate a column for how many columns were chosen 1-3
    for _ in range(cols):
        column = []
        # Need to make a copy of the all_symbols list so that we can remove items that were already used. To copy a list we can use [:] which is a slice op
        current_symbols = all_symbols[:]
        for _ in range(rows):
            value = random.choice(current_symbols)
            current_symbols.remove(value)
            # Add value to column
            column.append(value)
            
        columns.append(column)
        
    return columns

def print_slot_machine(columns):
    #Transposing?
    # Loop through every row we have. for every row we loop through every column. for every column we only print the current row we are on
    for row in range(len(columns[0])):
        for i, column in enumerate(columns):
            if i != len(columns) - 1:
                print(column[row], end= ' | ')
            else:
                print(column[row], end= '')
        # This print is what brings us to a new line to create the slot machine. Along with the two print lines above
        print()
                     
def deposit():
    # Create while loop to let user keep depositing money
    while True:
        amount = input('What would you like to deposit? $')
        # Check to make sure user entered in a num
        if amount.isdigit():
            # If num then convert amount to int
            amount = int(amount)
            # Check to make sure the num is higher than 0
            if amount > 0:
                # If vaild - break the loop and retun the num
                break
            else:
                print('Amount must be greater than 0.')
        else:
            print('Please enter in a number.')
    return amount

def get_number_of_lines():
    # Create while loop to let user keep betting
    while True:
        lines = input(f'Enter the number of lines to bet on (1-{str(MAX_LINES)})? ')
        # Check to make sure user entered in a num
        if lines.isdigit():
            # If num then convert amount to int
            lines = int(lines)
            # Check to see if lines is inbetween 1 and Max(3)
            if 1 <= lines <= MAX_LINES:
                # If vaild - break the loop and retun the num
                break
            else:
                print('Enter a vaild number of lines.')
        else:
            print('Please enter in a number.')
    return lines

def get_bet():
    # Create while loop to let user keep depositing money
    while True:
        amount = input('What would you like to bet on each line? $')
        # Check to make sure user entered in a num
        if amount.isdigit():
            # If num then convert amount to int
            amount = int(amount)
            # Check to make sure the num is higher than 0
            if MIN_BET <= amount <= MAX_BET:
                # If vaild - break the loop and retun the num
                break
            else:
                print(f'Amount must be between ${MIN_BET} - ${MAX_BET}.')
        else:
            print('Please enter in a number.')
    return amount
    
def spin(balance):
    lines = get_number_of_lines()
    # Creating a while loop to make sure they can only bet what is in their balance
    while True:
        bet = get_bet()
        total_bet = bet * lines
        
        if total_bet > balance:
            print(f'You do not have enough to bet that amount. Your balance is: ${balance}')
        else:
            break
    
    print(f'You are betting ${bet} on {lines} lines. Total bet is equal to: {total_bet}')
    
    slots = get_slot_machine_spin(ROWS, COLS, symbol_count)
    print_slot_machine(slots)
    winnings, winning_lines = check_winnings(slots, lines, bet, symbol_value)
    print(f'You won ${winnings}')
    print(f'You on lines', *winning_lines)
    return winnings - total_bet

def main():
    balance = deposit()
    while True:
        print(f'Current balance is: ${balance}')
        answer = input('Press enter to play (q to quit).')
        if answer == 'q':
            break
        else:
            balance += spin(balance)
            
    print(f'You left with: ${balance}')
    
main()