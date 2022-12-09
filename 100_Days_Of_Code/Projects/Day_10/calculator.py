# Calculator Operators
from art import logo

def add(n1, n2):
    '''Addition'''
    return n1 + n2

def subtract(n1, n2):
    '''Subtraction'''
    return n1 - n2

def multiply(n1, n2):
    '''Multiplication'''
    return n1 * n2

def divide(n1, n2):
    '''Division'''
    return n1 / n2

operations = {
    '+': add,
    '-': subtract,
    '*': multiply,
    '/': divide,
}

# Putting all this into a calc function and being able to call itself to start over from the top is called 'recursion'

def calculator():
    print(logo)
    num1 = float(input('What is the first number?: '))

    for symbol in operations:
        print(symbol)

    should_continue = True

    while should_continue:
        operation_symbol = input('Pick an operation: ')
        num2 = float(input('What is the next number?: '))
        calcution_func = operations[operation_symbol]
        anwser = calcution_func(num1, num2)

        print(f'{num1} {operation_symbol} {num2} = {anwser}')

        question = input(f'Type "y" to continue calculating with {anwser} or type "n" to start a new calculation or type "q" to quit: ')
        if question == 'y':
            num1 = anwser
        elif question == 'q':
            break
        else: 
            should_continue = False
            calculator()

calculator()