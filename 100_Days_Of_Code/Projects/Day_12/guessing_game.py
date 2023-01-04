import random
from art import logo

print(logo)
print('Welcome to the Number Guessing Game!')
print("I'm thinking of a number between 1 and 100.")

difficulty = input('Choose a difficulty. Type "easy or "hard": ')
if difficulty == 'easy':
    number_guess = 10 
else:
    number_guess = 5

print(f'You have {number_guess} attempts remaining to guess the number')

number = random.choice(range(1, 101))
print(number)

while True:
    guess = input('Make a guess: ')
    try:
        if guess.isdigit():
            if int(guess) == number:
                print(f'You got it! The answer was {number}, you win!')
                break

            elif int(guess) > number:
                print('Too high.')
                print('Guess again')
                number_guess -= 1
            
            elif int(guess) < number:
                print('Too low.')
                print('Guess again')
                number_guess -= 1
            
            print(f'You have {number_guess} attempts remaining to guess the number')
            
            if number_guess == 0:
                print(f'You did not guess the number: {number}, you lose!')
                break
        else:
            print('Please choose a number')
    except ValueError:
        pass
    