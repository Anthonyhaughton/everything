# Calculator Operators

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

func = operations['+']
func(3, 2)

num1 = int(input('What is the first number?: '))

for symbol in operations:
    print(symbol)

num2 = int(input('What is the second number?: '))

operation_symbol = input('Pick an operation from the line above: ')

calcution_func = operations[operation_symbol]
anwser = calcution_func(num1, num2)


# if operation_symbol == '+':
#     anwser = add(num1, num2)
# elif operation_symbol == '-':
#     anwser = subtract(num1, num2)
# elif operation_symbol == '*':
#     anwser = multiply(num1, num2)
# elif operation_symbol == '/':
#     anwser = divide(num1, num2)

print(f'{num1} {operation_symbol} {num2} = {anwser}')






